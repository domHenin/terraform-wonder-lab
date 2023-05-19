# TODO::
# - start modulizing


provider "aws" {
  region = var.aws_region
}



module "compute_base" {
  source = "./modules/aws/instance-base"

  network_sub_pub  = module.network_base.sub_pub_id
  network_sub_priv = module.network_base.sub_priv_id

  network_sg = module.network_base.sg_pub

}


module "network_base" {
  source = "./modules/aws/network-base"
}

