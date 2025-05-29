variable "common_tags" {}
variable "naming_prefix" {}
variable "vpc_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "subnet_id" {}
variable "ec2_name" {}
variable "sg_ingress_ports" {
  type = list(object({
    description = string
    port        = number
  }))
  default = [
    {
      description = "Allows SSH access"
      port        = 22
    },
    {
      description = "Allows HTTP traffic"
      port        = 80
    },
  ]
}

