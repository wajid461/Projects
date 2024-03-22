variable "subnet_id" {}
variable "jump_security_group" {}

resource "aws_instance" "jump_instance" {
  ami           = "ami-0c7217cdde317cfec"   # Update this with your desired AMI ID
  instance_type = "t2.micro"      # Update this with your desired instance type
  subnet_id     = var.subnet_id
  associate_public_ip_address = true
  key_name = "test"
  security_groups = [var.jump_security_group]

  root_block_device {
    delete_on_termination = true
    volume_size = 8
    volume_type = "gp2"
  }

  tags = {
    Name = "jumpserver"
  }

  depends_on = [ var.jump_security_group ]
}

output "jump_instance_ip" {
  value = aws_instance.jump_instance.public_ip
}