variable "subnet_id" {}
variable "webserver_security_group" {}

resource "aws_instance" "webserver_instance" {
  ami = "ami-0c7217cdde317cfec"   # Update this with your desired AMI ID
  instance_type = "t2.micro"      # Update this with your desired instance type
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  key_name = "test"
  security_groups = [var.webserver_security_group]

  // Bootstrapping the Web Server
  user_data = <<-EOF
		#!/bin/bash
    sudo apt-get update
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
	EOF

  root_block_device {
    delete_on_termination = true
    volume_size = 8
    volume_type = "gp2"
  }

  tags = {
    Name = "webserver"
  }

  depends_on = [ var.webserver_security_group ]
}

output "webserver_instance_ip" {
  value = aws_instance.webserver_instance.public_ip
}
