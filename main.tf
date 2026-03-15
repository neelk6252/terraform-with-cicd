resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr
    tags = {
        Name = "dev-vpc"
    }
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.dev-vpc.id
  for_each = var.public_subnet_cidr
  cidr_block = each.value
    tags = {
        Name = "public-subnet-${each.key}"
    }
}
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.dev-vpc.id
  for_each = var.private_subnet_cidr
  cidr_block = each.value
    tags = {
        Name = "private-subnet-${each.key}"
    }
}

resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id
    tags = {
        Name = "dev-igw"
    }
}

resource "aws_route_table" "public-route" {
    vpc_id = aws_vpc.dev-vpc.id
        tags = {
            Name = "public-route"
        }
  
}

resource "aws_route_table" "private-route" {
    vpc_id = aws_vpc.dev-vpc.id
        tags = {
            Name = "private-route"
        }
  
}

resource "aws_route_table_association" "public-subnet-association" {
  for_each      = aws_subnet.public-subnet
  subnet_id     = each.value.id
  route_table_id = aws_route_table.public-route.id
}


resource "aws_route_table_association" "private-subnet-association" {
  for_each      = aws_subnet.private-subnet
  subnet_id     = each.value.id
  route_table_id = aws_route_table.private-route.id
}

resource "aws_route" "igw-map" {
  route_table_id = aws_route_table.public-route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.dev-igw.id
}

resource "aws_security_group" "dev-sg" {
  name = var.secrity_sg
  description = "Security group for dev vm"
  vpc_id = aws_vpc.dev-vpc.id
    tags = {
        Name = "dev-sg${var.secrity_sg}"
    }
}

resource "aws_security_group_rule" "ec2-sg-rule" {
  security_group_id = aws_security_group.dev-sg.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_instance" "ec2-public" {
    ami = "ami-06c643a49c853da56"
    instance_type = var.vm_size
    subnet_id = values(aws_subnet.public-subnet)[0].id
    vpc_security_group_ids = [aws_security_group.dev-sg.id]
    key_name = var.ssh-key
    tags = {
        Name = var.vm_name
    }
  
}