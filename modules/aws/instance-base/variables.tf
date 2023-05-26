#------------------------------------------------
# instance-base: variables                     #
# ./modules/aws/instance-base/variables.tf     #
#------------------------------------------------

variable "instance_type" {
  description = "type of instance for build"
  type        = string
  default     = "t2.micro"
}

variable "apache_tag" {
  description = "tag name for apache webserver"
  type        = string
  default     = "apache_ws"
}

variable "database_tag" {
  description = "tag name for database server"
  type        = string
  default     = "mysql_db"
}

variable "private_security_group_id" {
  description = "private security group id"
  type        = string
}


variable "public_subnet_id" {
  description = "public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "private subnet"
  type        = string
}

variable "public_security_group_id" {
  description = "security group"
  type        = string
}