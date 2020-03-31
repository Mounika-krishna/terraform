variable "instance_ami"{
  description = "my ec2 instance"
  #default           = "ami-0a887e401f7654935"
}
variable  "instance_type"{
  #default = "t2.micro"
}

variable "key_name" {
  #default = "terraform"
}
variable "environment_tag" {
  description = "Environment tag"
  #default = "Production"
}
variable "vpcsgid"{
  #default = "sg-0459403b93c7f2e35"
}

variable "subnetid"{
  #default = "subnet-0f71e045651452b98"
}
