provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}
resource "random_id" "randomid" {

  byte_length = 1
}
/* s3 bucket creation */
resource "aws_s3_bucket" "s3" {
  bucket = "my-tf-test-bucket-${random_id.randomid.dec}"

}

/* VPC creation */

variable "myvpc_name"{
  default = "myvpc"
}
variable "myvpc_cidr"{
  default = "192.30.0.0/16"
}
resource "aws_vpc" "myvpc" {
  cidr_block       = "${var.myvpc_cidr}"

  tags = {
    Name = "${var.myvpc_name}"
  }
}

/* IGW creation */

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags = {
    Name = "myigw"
  }
}

/* route table */

resource "aws_route_table" "route" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "myroute"
  }

}
/* subnet */

resource "aws_subnet" "subnet" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "192.30.0.0/24"
  map_public_ip_on_launch = "true"
 availability_zone = "us-east-1a"
 tags = {
    Name = "Mysubnet"
  }
}

/* subnet association */

resource "aws_route_table_association" "myrouteassociate" {
  subnet_id      = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.route.id}"
}


/* SG */

resource "aws_security_group" "mysg" {
  vpc_id      = "${aws_vpc.myvpc.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags ={
    Name = "mysg"
  }
}
output "mysubnetid"{
  value = "${aws_subnet.subnet.id}"
}

output "mysgid"{
  value = "${aws_security_group.mysg.id}"
}

/* ec2 ceation */


/* ec2 */

variable "instance_ami"{
  description = "my ec2 instance"
  default           = "ami-0a887e401f7654935"
}
variable  "instance_type"{
  default = "t2.micro"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}

resource "aws_instance" "testInstance" {
  ami           = "${var.instance_ami}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.mysg.id}"]
  subnet_id = "${aws_subnet.subnet.id}"
  key_name = "terraform"
 tags {
    Name = "${var.environment_tag}"
 }
}

