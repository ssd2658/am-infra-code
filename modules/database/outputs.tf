output "database_name" {
  description = "Name of the created database"
  value       = var.database_name
}

output "database_endpoint" {
  description = "Endpoint of the database"
  value       = ""  # To be overridden by cloud-specific implementations
  sensitive   = true
}

output "database_port" {
  description = "Port of the database"
  value       = 5432  # Default PostgreSQL port
  sensitive   = true
}
