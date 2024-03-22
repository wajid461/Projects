resource "aws_vpc" "my_vpc" {
  
  cidr_block = "10.0.0.0/16"  # Update this with your desired CIDR block
  enable_dns_support = true
  enable_dns_hostnames = true
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}