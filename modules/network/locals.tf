locals {
  cidr_block           = [for each in range(4) : cidrsubnet(var.cidr_block, 2, each)]
  public_regon_subnet  = zipmap(slice(local.cidr_block, 0, 2), ["a", "b"])
  private_regon_subnet = zipmap(slice(local.cidr_block, 2, 4), ["c", "d"])
}

