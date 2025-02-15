# Cloud Provider Selection
variable "cloud_provider" {
  description = "Cloud provider to use (gcp or azure)"
  type        = string
  default     = "gcp"
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

# Kubernetes Module
module "kubernetes_gcp" {
  count  = var.cloud_provider == "gcp" ? 1 : 0
  source = "./modules/kubernetes/gcp"

  cluster_name = var.cluster_name
  region       = var.region
  project_id   = var.project_id

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

module "kubernetes_azure" {
  count  = var.cloud_provider == "azure" ? 1 : 0
  source = "./modules/kubernetes/azure"

  cluster_name = var.cluster_name
  region       = var.region
  project_id   = var.project_id

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Database Module
module "database_gcp" {
  count  = var.cloud_provider == "gcp" ? 1 : 0
  source = "./modules/database/gcp"

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

module "database_azure" {
  count  = var.cloud_provider == "azure" ? 1 : 0
  source = "./modules/database/azure"

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