# TODO::
# - start modulizing


provider "aws" {
  region = var.aws_region
}


module "compute_base" {
  source = "./modules/aws/compute-base/"



  public_subnet_id  = module.network_base.public_subnet
  private_subnet_id = module.network_base.private_subnet

  public_security_group_id = module.network_base.public_security_group
  # private_security_group_id = module.network_base.private_security_group
}

module "network_base" {
  source = "./modules/aws/network-base"
}


