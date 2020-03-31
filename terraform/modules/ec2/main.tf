resource "aws_instance" "testInstance" {
  ami           = "${var.instance_ami}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${var.vpcsgid}"]
  subnet_id = "${var.subnetid}"
  key_name = "${var.key_name}"
 tags {
    Name = "${var.environment_tag}"
 }
}
