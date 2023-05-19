#-----------------------------------------
# Network: Configure
#-----------------------------------------


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

# resource "aws_internet_gateway_attachment" "wl_igw_att" {
#   internet_gateway_id = aws_internet_gateway.wl_igw.id
#   vpc_id              = aws_vpc.vpc_wonder_lab.id
# }

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

  #   route {
  #     cidr_block = var.priv_sub_cidr
  #     gateway_id = aws_internet_gateway.wl_igw.id
  #   }

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
    "Name" = var.public_sg_tag
  }
}

resource "aws_security_group" "private_sg" {
  name        = var.private_sg_name
  description = var.private_sg_description
  vpc_id      = aws_vpc.vpc_wonder_lab.id

  ingress {
    description      = "Allow traffic on port 22 from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.private_sg_tag
  }
}