#-----------------------------------------
# VARIABLES:- Compute: Configure
#-----------------------------------------


variable "instance_type" {
  description = "type of instance"
  type        = string
  default     = "t3.micro"
}

variable "apache_tag" {
  description = "tags for apache webserver"
  type        = string
  default     = "apache_instance"
}

variable "database_tag" {
  description = "tags for database webserver"
  type        = string
  default     = "database_instance"
}


# variable "vpc_id" {
#   description = "vpc id"
#   type = string
# }

variable "public_subnet_id" {
  description = "public subnet id"
  type        = string
}

variable "private_subnet_id" {
  description = "private subnet id"
  type        = string
}

variable "public_security_group_id" {
  description = "public security group id"
  type        = string
}

# variable "private_security_group_id" {
#   description = "private security group id"
#   type = string
# }