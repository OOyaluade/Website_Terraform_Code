module "network" {
  source = "./modules/network"
}


# module "server_1" {
#   depends_on          = [module.network]
#   source              = "./modules/servers"
#   subnet_id           = local.public_subnet_details[local.subnet_list[0]].id # Index of the subnet range started form the highest cidr to the lowest in the list 3,2,1,0
#   security_groups     = local.security_groups.id
#   instance_name_tag   = "Associated"
#   associate_public_ip = true

# }
