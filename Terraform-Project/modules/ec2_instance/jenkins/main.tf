variable "subnet_id" {}
variable "jenkins_security_group" {}

resource "aws_instance" "jenkins" {
    ami = "ami-0c7217cdde317cfec"
    instance_type = "t2.micro"
    subnet_id = var.subnet_id
    associate_public_ip_address = true
    key_name = "test"
    security_groups = [var.jenkins_security_group]

    // Bootstrapping the Jenkins Server
    user_data = <<-EOF
    	#!/bin/bash
        apt update
        apt upgrade -y
        apt install openjdk-17-jdk -y
    	apt install -y nginx
    	systectl enable nginx
        systectl start nginx
        sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
        https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
        echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
        https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
        /etc/apt/sources.list.d/jenkins.list > /dev/null
        apt update
        apt install -y jenkins
        systemctl enable jenkins
        systemctl start jenkins
    EOF
    root_block_device {
        delete_on_termination = true
        volume_size = 8
        volume_type = "gp2"
    }

    tags = {
        Name = "jenkins"
    }

    depends_on = [ var.jenkins_security_group ]
}

output "jenkins_instance_ip" {
  value = aws_instance.jenkins.public_ip
}