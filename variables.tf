variable "cloud_provider" {
  description = "Cloud provider to use (gcp or azure)"
  type        = string
  validation {
    condition     = contains(["gcp", "azure"], var.cloud_provider)
    error_message = "Cloud provider must be either 'gcp' or 'azure'."
  }
}

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

variable "tags" {
  description = "Optional tags to apply to resources"
  type        = map(string)
  default     = {}
}
