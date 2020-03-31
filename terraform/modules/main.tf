# working with modules

module "storage"{
  source = "./s3"
  mys3bucket_name = "mounika"
}
module "network"{
  source = "./vpc"
  myvpc_name = "mounia-vpc"
  myvpc_cidr = "192.30.0.0/16"
  myigw_name  = "mounika-igw"
  myroute_name = "mounika_route"
  mypubsubnet_name = "mounika-route"
  mypubsubnet_cidr = "192.30.10.0/24"
  mysg_name = "mounikasg"
}

module "compute"{
  source = "./ec2"
  environment_tag = "mounika"  
  key_name = "terraform"
  instance_type = "t2.micro"
  instance_ami = "ami-0a887e401f7654935"
  vpcsgid = "${module.network.mysgid}"
  subnetid = "${module.network.mysubnetid}"
}
