variable "vpc_id" {}

resource "aws_security_group" "webserver_security_group" {
  name        = "webserver_security_group"
  description = "Allow inbound traffic on port 22 and 80"
  vpc_id      = var.vpc_id

  //SSH Port to be accessed from the VPC
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "10.0.0.0/16" ]
  }
  
  //HTTP Port
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  //HTTPS Port
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

}

output "webserver_security_group_id" {
  value = aws_security_group.webserver_security_group.id
}

