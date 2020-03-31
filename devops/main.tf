module "dvs-storage"{
  source = "/root/terraform/modules/s3"
  mys3bucket_name = "mydevs3bucket"
}
