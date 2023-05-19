output "sub_pub_id" {
  description = "public subnet id"
  value       = aws_subnet.public_subnet.id
}

output "sub_priv_id" {
  description = "private subnet id"
  value       = aws_subnet.private_subnet.id
}


output "sg_pub" {
  description = "public security group"
  value       = aws_security_group.public_sg.id
}

# output "sg_priv" {
#     description = "prvate security group"
#     value = aws_security_group.private_sg.id
# }