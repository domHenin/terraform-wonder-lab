output "web-server-url" {
  description = "web-server-url"
  value       = join("", ["http://", aws_instance.apache_ws.public_ip])
}

output "database-server-url" {
  description = "database-server-url"
  value       = join("", ["http://", aws_instance.database_instance.public_ip])
}

output "Time-Date" {
  description = "Date/Time of Execution"
  value       = timestamp()
}