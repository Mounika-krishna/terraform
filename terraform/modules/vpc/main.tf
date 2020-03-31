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
    Name = "${var.myigw_name}"
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
    Name = "${var.myroute_name}"
  }

}
/* subnet */

resource "aws_subnet" "subnet" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "${var.mypubsubnet_cidr}"
  map_public_ip_on_launch = "true"
 availability_zone = "us-east-1a"
 tags = {
    Name = "${var.mypubsubnet_name}"
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
    Name = "${var.mysg_name}"

  }
}




