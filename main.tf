
locals {
  kubernetes_module_source = var.cloud_provider == "gcp" ? "./modules/kubernetes/gcp" : "./modules/kubernetes/azure"
  database_module_source   = var.cloud_provider == "gcp" ? "./modules/database/gcp" : "./modules/database/azure"
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