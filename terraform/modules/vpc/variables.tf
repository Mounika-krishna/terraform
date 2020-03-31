variable "myvpc_name"{
   description = " enter vpc name:"
   #default = "myvpc"
}
variable "myigw_name"{
  description = "enter iGW name: "
 # #default = "myigw"
}

variable "myroute_name"{
  description = "route name:"
  #default = "myroute"
}

variable "mypubsubnet_name"{
  description = "subnet name :"

  #default = "mypubsubnet"
}
variable "myvpc_cidr"{
  description = "cidr block/vpc range:"
  #default = "192.30.0.0/16"
}

variable "mypubsubnet_cidr"{
  description = "subnet ip cidr"
  #default = "192.30.1.0/24"
}
variable "mysg_name"{
  description = "SG name:"
  #default = "mysg"
}
