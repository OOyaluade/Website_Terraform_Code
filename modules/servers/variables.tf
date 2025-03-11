variable "instance_type" {
  type    = string
  default = "t2.micro"

}

variable "subnet_id" {
  type        = string
  description = "subnet_id from the resource"

}


variable "rsa_instance_private_keystore_location" {
  type    = string
  default = "modules/servers/"

}

variable "save_rsa_private_key_locally_name" {
  type    = string
  default = "private_key.pem"

}

variable "save_rsa_public_key_locally_name" {
  type    = string
  default = "public_key.pub"

}

variable "rsa_instance_public_keystore_location" {
  type    = string
  default = "modules/servers/"

}


variable "security_groups" {}

variable "instance_name_tag" {}

variable "associate_public_ip" {
  type = bool

}

