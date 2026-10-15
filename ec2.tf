# key pair

resource "aws_key_pair" "my_key" {
  key_name   = "${var.env}-terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

# VPC & Security Group
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}


# Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.subnet_az
  map_public_ip_on_launch = var.ec2_assign_pub_ip

  tags = {
    Name = "public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ig_main"
  }
}

# Route Table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# route_table_association
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "sg-main" {
  vpc_id = aws_vpc.main.id
  # Interpolation 
  name        = "sgmain"
  description = "security group created associated with main vpc created using tf"

  tags = {
    Name = "sg-main"
    Environment = var.env
  }

  # Inbound Rules
  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    description = "allowing ssh in inbound rules"

  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "allowing http in inbound rules"
  }
  # Outbound Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# to get the information about ami to use
# use this 
# aws ec2 describe-images \
#    --owners amazon \
#    --filters "Name=name,Values=RHEL-9*" \                 
#        "Name=virtualization-type,Values=hvm" \
#    --query "Images[*].[Name,ImageId,OwnerId]" \
#    --output table 

# EC2 Instance
data "aws_ami" "rhel-9" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-9*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["309956199498"]
}

resource "aws_instance" "rhel-9-instance" {
  #count = 2 #meta argument
  for_each = tomap({
    rhel-instance-1 = "t3.micro"
    # rhel-instance-2 = "t3.micro"
    
  })

  depends_on = [ aws_security_group.sg-main, aws_key_pair.my_key ]
  #for_each iterate through the collection one by one and create one resource per entry.
  # tomap - stores the collection in key-value pair
  # to use value use each.value and similarly to use key use each.key
  ami                    = data.aws_ami.rhel-9.id
  key_name               = aws_key_pair.my_key.key_name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.sg-main.id]
  instance_type          = each.value

  user_data = file("nginx-install.sh")

  root_block_device {
    volume_size = var.env == "prd" ? 20 : var.ec2_root_volume_size
    #ternary operator
    volume_type = var.ec2_root_volume_type
  }


  tags = {
    Name = each.key
    Environment = var.env
  }
}

# creating a config for a resource that is present on aws not created by terraform

# resource "aws_instance" "new_instance" {
#     ami = "unknown"
#     instance_type = "unknown"
# }

# use import aws_instance.new_instance i-0e0be12e34e4e3158