output "myvpcname"{
  value = "${aws_vpc.myvpc.tags.Name}"
}

output "mysubnetid"{
  value = "${aws_subnet.subnet.id}"
}
output "mysgid"{
  value = "${aws_security_group.mysg.id}"
}
