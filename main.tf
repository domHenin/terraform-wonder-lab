# TODO::
# - add a new ssh keygen specific for 'dell-wsl_key'
# - create new key pair -- learn  -- check
# - install db  --> check
# - start modulizing
# - move over to terraspace

provider "aws" {
  region = var.aws_region
}



module "compute_base" {
  source = "./modules/aws/compute-base"

  network_sub_pub  = module.network_base.sub_pub_id
  network_sub_priv = module.network_base.sub_priv_id

  network_sg = module.network_base.sg_pub

}


module "network_base" {
  source = "./modules/aws/network-base"
}

