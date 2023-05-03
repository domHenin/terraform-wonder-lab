# TODO::
# - create new key pair -- learn  -- check
# - install db  --> check
# - start modulizing
# - move over to terraspace

provider "aws" {
  region = var.aws_region
}


resource "aws_vpc" "vpc_wonder_lab" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_tags
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc_wonder_lab.id
  cidr_block = var.pub_sub_cidr

  tags = {
    Name = var.pub_sub_tags
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_wonder_lab.id
  cidr_block = var.priv_sub_cidr

  tags = {
    Name = var.priv_sub_tags
  }
}

resource "aws_internet_gateway" "wl_igw" {
  vpc_id = aws_vpc.vpc_wonder_lab.id

  tags = {
    Name = var.wl_igw_tags
  }
}

resource "aws_internet_gateway_attachment" "wl_igw_att" {
  internet_gateway_id = aws_internet_gateway.wl_igw.id
  vpc_id              = aws_vpc.vpc_wonder_lab.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_wonder_lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wl_igw.id
  }

  #   route {
  #     ipv6_cidr_block        = "::/0"
  #     egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  #   }

  tags = {
    Name = "wonder_lab_public_route_table"
  }
}

resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc_wonder_lab.id

  # route {
  #   cidr_block = var.priv_sub_cidr
  #   gateway_id = aws_internet_gateway.wl_igw.id
  # }

  #   route {
  #     ipv6_cidr_block        = "::/0"
  #     egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  #   }

  tags = {
    Name = "wonder_lab_private_route_table"
  }
}

resource "aws_route_table_association" "private_rt_asso" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}


resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.vpc_wonder_lab.id
  name   = join("_", ["sg", aws_vpc.vpc_wonder_lab.id])
  dynamic "ingress" {
    for_each = var.public_rules
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "sg_webserver"
  }
}


# resource "aws_security_group" "private_sg" {
#   vpc_id = aws_vpc.vpc_wonder_lab.id
#   name   = join("_", ["sg", aws_vpc.vpc_wonder_lab.id])
#   dynamic "ingress" {
#     for_each = var.private_rules
#     content {
#       from_port   = ingress.value["port"]
#       to_port     = ingress.value["port"]
#       protocol    = ingress.value["proto"]
#       cidr_blocks = ingress.value["cidr_blocks"]
#     }
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     "Name" = "sg_webserver"
#   }
# }


data "aws_ssm_parameter" "ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "provision_key"
  public_key = file("~/.ssh/wonder_lab.pub")
}

resource "aws_instance" "apache_ws" {
  ami                         = data.aws_ssm_parameter.ami_id.value
  subnet_id                   = aws_subnet.public_subnet.id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name
  user_data                   = fileexists("files/apache_install.sh") ? file("files/apache_install.sh") : null
}

resource "aws_instance" "database_instance" {
  ami                         = data.aws_ssm_parameter.ami_id.value
  subnet_id                   = aws_subnet.private_subnet.id
  instance_type               = var.instance_type
  # security_groups             = [aws_security_group.private_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name
  user_data                   = fileexists("files/mysql_install.sh") ? file("files/apache_install.sh") : null
}