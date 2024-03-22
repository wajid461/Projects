variable "vpc_id"{}

resource "aws_security_group" "jenkins_security_group" {
    name = "jenkins_security_group"
    description = "Allow inbound traffic on port 8080"
    vpc_id = var.vpc_id

    //SSH Port
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
        }

    //Jenkins Port
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }

    lifecycle { 
        create_before_destroy = true
    } 
}

output "jenkins_security_group_id" {
    value = aws_security_group.jenkins_security_group.id
}