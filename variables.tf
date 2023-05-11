variable "aws_region" {
  description = "region for infrastructure"
  type        = string
  default     = "us-east-1"
}

# ------------------------------

module "aws_vpc_module" {
  source = "./modules/aws/network-base"


}


# ------------------------------

