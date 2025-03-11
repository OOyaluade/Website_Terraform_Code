
locals {
  private_subnet_details = module.network.private_subnet
  public_subnet_details  = module.network.public_subnet
  subnet_list            = module.network.subnet_id_list
  security_groups        = module.network.security_groups

}