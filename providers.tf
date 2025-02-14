terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.84.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
  }
}

provider "google" {
  project = var.cloud_provider == "gcp" ? var.project_id : null
  region  = var.cloud_provider == "gcp" ? var.region : null
}

provider "azurerm" {
  features {}
  subscription_id = var.cloud_provider == "azure" ? var.project_id : null
  region          = var.cloud_provider == "azure" ? var.region : null
}

provider "kubernetes" {
  host  = "https://${google_container_cluster.primary.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  )
}
