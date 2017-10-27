provider "aws" {
		region = "us-west-2" }

variable "server_port" {
description = "the security group port for http"
default	=	8080
}

resource "aws_instance" "single_linux" {
					ami	=	"ami-6e1a0117"
					instance_type	=	"t2.micro"
					tags	=	{ Name = "terratest" }
vpc_security_group_ids = ["${aws_security_group.firstsg.id}"]
user_data = <<-EOF
		#!/bin/bash
		echo "hello, world" > index.html
		nohup busybox httpd -f -p "${var.server_port}" &
		EOF
}

resource "aws_security_group" "firstsg" {
name= "single-instance-firstsg"

ingress {
from_port = "${var.server_port}"
to_port	= "${var.server_port}"
protocol	= "tcp"
cidr_blocks	= ["0.0.0.0/0"]
}
}

output "public_ip" {
value = "${aws_instance.single_linux.public_ip}"
}