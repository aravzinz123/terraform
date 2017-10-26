provider "aws" {
		region = "us-west-2" }

resource "aws_instance" "single_linux" {
					ami	=	"ami-9fa343e7"
					instance_type	=	"t2.micro"
					tags	=	{ Name = "terratest" }
							}