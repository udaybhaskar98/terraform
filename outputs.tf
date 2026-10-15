# output block shows the output of an attribute of a resource on the cli 
# output block -> paramater {use string interpolation to get the value of the resource}

output "ec2_public_ip" {
  value = [
    for instance in aws_instance.rhel-9-instance : instance.public_ip
  ]
}

# output "ec2_public_dns" {
#   value = aws_instance.rhel-9-instance.public_dns
# }

output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.public.id

}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "pub_rt_id" {
  value = aws_route_table.public.id

}

output "sg_id" {
  value = aws_security_group.sg-main.id

}

output "ami_id" {
  #value = aws_instance.rhel-9-instance.id
  value = [
    for instance in aws_instance.rhel-9-instance : instance.ami
  ]
}

