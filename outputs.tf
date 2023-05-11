output "web-server-url" {
  description = "web-server-url"
  value = module.compute_base.web-server-url
}

output "database-server-url" {
  description = "database-server-url"
  value = module.compute_base.database-server-url
}

output "Time-Date" {
  description = "Date/Time of Execution"
  value = module.compute_base.time-date
}

