#-----------------------------------------
# OUTPUTS:- Network: Configure
#-----------------------------------------

# output: subnet_id --- public/private
# output: security_groups  --- public/private



output "vpc_id" {
  description = "output vpc id"
  value = aws_vpc.vpc_wonder_lab.id
  
}

output "public_subnet" {
  description = "output public subnet"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet" {
  description = "output private subnet"
  value       = aws_subnet.private_subnet.id
}


output "public_security_group" {
  description = "output public security group"
  value       = aws_security_group.public_sg.id
}

# ouptut "private_security_group" {
#   description = "output private security group"
#   value       = aws_security_group.private_sg.id
# }