output "cluster_name" {
  description = "Name of the created Kubernetes cluster"
  value       = var.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint of the Kubernetes cluster"
  value       = ""  # To be overridden by cloud-specific implementations
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "CA Certificate for cluster connection"
  value       = ""  # To be overridden by cloud-specific implementations
  sensitive   = true
}
