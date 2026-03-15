vpc_cidr = "10.1.0.0/16"
public_subnet_cidr = {
  "subnet-1a" = "10.1.0.0/28"
  "subnet-1b" = "10.1.1.0/28"
}
private_subnet_cidr = {
  "subnet-2a" = "10.1.2.0/28"
  "subnet-2b" = "10.1.3.0/28"
}

azs=["ap-south-1a","ap-south-1b"]

region="ap-south-1"
vm_name="neel-test-vm"
vm_size="t3.micro"
ssh-key="neel"
secrity_sg="neel-test-sg"
