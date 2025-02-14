# Cloud Provider Selection
variable "cloud_provider" {
  description = "Cloud provider to use (gcp or azure)"
  type        = string
  default  = "gcp"
  #validation {
  #  condition     = contains(["gcp", "azure"], var.cloud_provider)
  #  error_message = "Cloud provider must be either 'gcp' or 'azure'."
  #}
}

# Common Variables
variable "project_id" {
  description = "Project or Subscription ID"
  type        = string
}

variable "region" {
  description = "Cloud region"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "primary-cluster"
}

variable "database_name" {
  description = "Name of the database"
  type        = string
  default     = "primary-database"
}

variable "admin_username" {
  description = "Database admin username"
  type        = string
  sensitive   = true
}

variable "admin_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "The environment to deploy to (e.g., preprod, prod)"
  type        = string
}

locals {
  kubernetes_module_source = var.cloud_provider == "gcp" ? "./modules/kubernetes/gcp" : "./modules/kubernetes/azure"
}

# Kubernetes Module
module "kubernetes" {
  source = local.kubernetes_module_source

  cluster_name = var.cluster_name
  region       = var.region
  project_id   = var.project_id

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

locals {
  database_module_source = var.cloud_provider == "gcp" ? "./modules/database/gcp" : "./modules/database/azure"
}
# Database Module
module "database" {
  source = local.database_module_source

  database_name     = var.database_name
  region            = var.region
  project_id        = var.project_id
  admin_username    = var.admin_username
  admin_password    = var.admin_password

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Outputs
output "cluster_name" {
  value = module.kubernetes.cluster_name
}

output "database_name" {
  value = module.database.database_name
}

output "cluster_endpoint" {
  value     = module.kubernetes.cluster_endpoint
  sensitive = true
}

output "database_endpoint" {
  value     = module.database.database_endpoint
  sensitive = true
}
