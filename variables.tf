# variable "ec2_instance_type" {
#   type    = string
#   default = "t3.small"
# }

# variable "ec2_instance_name" {
#   type    = string
#   default = "rhel-machine"
# }

variable "ec2_root_volume_size" {
  type    = number
  default = 15
}

variable "ec2_root_volume_type" {
  type    = string
  default = "gp3"
}

variable "subnet_az" {
  type    = string
  default = "ap-south-1b"
}

variable "ec2_assign_pub_ip" {
  type    = bool
  default = true
}

variable "env" {
    default = "prod"
    type = string
}