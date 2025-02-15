variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "region" {
  description = "Cloud region"
  type        = string
}

variable "project_id" {
  description = "Project or Subscription ID"
  type        = string
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