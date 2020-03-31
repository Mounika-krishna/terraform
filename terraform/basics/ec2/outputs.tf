output "my_value"{
  value = "${aws_instance.ec2.public_ip}"
}
