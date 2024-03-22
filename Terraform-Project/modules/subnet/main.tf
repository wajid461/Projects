variable "vpc_id" {}

resource "aws_subnet" "public_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"  # Update this with your desired subnet CIDR block
  availability_zone = "us-east-1a"   # Update this with your desired availability zone
}

resource "aws_subnet" "private_subnet" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}