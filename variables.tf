variable "aws_region" {
  description = "region for infrastructure"
  type        = string
  default = "us-east-1"
}

# ------------------------------

variable "vpc_cidr" {
  description = "cidr range used for VPC"
  type        = string
  # default = "172.16.0.0/24"
  default = "172.16.0.0/16"
}

variable "vpc_tags" {
  description = "tags for VPC"
  type        = string
  default = "vpc_wonder_lab"
}

# ------------------------------


variable "pub_sub_cidr" {
  description = "cidr range used for public subnet"
  type        = string
  default = "172.16.1.0/24"
}

variable "pub_sub_tags" {
  description = "tags for public subnet"
  type        = string
  default = "public_subnet"
}

# ------------------------------

variable "priv_sub_tags" {
  description = "tags for private subnet"
  type        = string
  default = "private_subnet"
}

variable "priv_sub_cidr" {
  description = "cidr range used for private subnet"
  type        = string
  default = "172.16.2.0/24"
}


# ------------------------------

variable "wl_igw_tags" {
  description = "tags for internet gateway"
  type        = string
  default = "wl_igw"
}


# ------------------------------

variable "public_rules" {
  type = list(object({
    port        = number
    proto       = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      port        = 80
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 22
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 3689
      proto       = "tcp"
      cidr_blocks = ["6.7.8.9/32"]
    }
  ]
}

variable "private_rules" {
  type = list(object({
    port        = number
    proto       = string
    cidr_blocks = list(string)
  }))
  default = [
    # {
    #   port        = 80
    #   proto       = "tcp"
    #   cidr_blocks = ["0.0.0.0/0"]
    # },
    {
      port        = 22
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    #   {
    #     port        = 3689
    #     proto       = "tcp"
    #     cidr_blocks = ["6.7.8.9/32"]
    #   }
  ]
}



# ------------------------------

variable "instance_type" {
  description = "type of instance"
  type        = string
  default = "t3.micro"
}