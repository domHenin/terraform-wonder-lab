#-----------------------------------------
# VARIABLES:- Instance: Configure
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