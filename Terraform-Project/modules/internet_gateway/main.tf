variable "vpc_id" {}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "my_igw"
  }
}

output "igw_id" {
  description = "The ID of the VPC"
  value = aws_internet_gateway.my_igw.id
}