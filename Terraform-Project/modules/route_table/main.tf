variable "vpc_id" {}
variable "my_igw" {}
variable "public_subnet" {}

resource "aws_route_table" "my_route_table" {
  vpc_id = var.vpc_id  

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.my_igw
  }

  tags = {
    Name = "my_route_table"
  }
}

resource "aws_route_table_association" "name" {
  subnet_id = var.public_subnet
  route_table_id = aws_route_table.my_route_table.id
}

