variable "env"{
  description = "dev or prod"
}
variable "my_servername"{
  default = {
    "dev" = "server_dev"
    "prod" = "server_prod"
  }
}
variable "my_key_name"{
  default = {
    "dev" = "dev_key"
    "prod" = "prod_key"
  }
}
