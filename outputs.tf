# Kubernetes Cluster Outputs
output "cluster_name" {
  description = "Name of the created Kubernetes cluster"
  value       = module.kubernetes.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint of the Kubernetes cluster"
  value       = module.kubernetes.cluster_endpoint
  sensitive   = true
}

# Database Outputs
output "database_name" {
  description = "Name of the created database"
  value       = module.database.database_name
}

output "database_endpoint" {
  description = "Endpoint of the database"
  value       = module.database.database_endpoint
  sensitive   = true
}

# Cloud Provider Information
output "cloud_provider" {
  description = "Selected cloud provider"
  value       = var.cloud_provider
}
