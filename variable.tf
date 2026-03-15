variable "vpc_cidr" {
  type = string
  description = "CIDR of vpc dev"
}
variable "public_subnet_cidr" {
  type = map(string)
  description = "CIDR of public subnet dev"
}
variable "private_subnet_cidr" {
  type = map(string)
  description = "CIDR of private subnet dev"
}
variable "azs" {
  type = list(string)
  description = "AZs of dev"
}
variable "region" {
  type = string
  description = "Region of dev"
}

variable "vm_name" {
    type = string
    description = "Name of vm"
  
}
variable "vm_size" {
    type = string
    description = "Size of vm"
  
}
variable "ssh-key" {
  type = string
  description = "SSH key for vm"
}
variable "secrity_sg" {
  type = string
  description = "Security group for vm"
}