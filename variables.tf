#------------------------------------------------
# : variables                                   #
# ./variables.tf                                #
#------------------------------------------------


variable "aws_region" {
  description = "region for infrastructure"
  type        = string
  default     = "us-east-1"
}

# ------------------------------
