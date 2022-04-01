resource "aws_instance" "server1"{
ami = var.ami_id
instance_type = var.instance_type
tags = {
Name = "my terraform instance"
}

}

resource "aws_key_pair" "key_p"{
key_name="my_key_p"
public_key= var.public_key
}

resource "aws_security_group" "my_SG"{
name = "my_SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["172.31.0.0/16"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
