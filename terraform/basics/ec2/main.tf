provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "ec2" {
  ami           = "ami-0a887e401f7654935"
  instance_type = "t2.micro"
  key_name = "${lookup(var.my_key_name,var.env)}"

  tags = {
    Name = "${lookup(var.my_servername,var.env)}"
  }
}
