variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "region" {
  description = "Cloud region for the database"
  type        = string
}

variable "database_version" {
  description = "Version of the database engine"
  type        = string
  default     = "POSTGRES_15"
}

variable "instance_type" {
  description = "Database instance type/size"
  type        = string
  default     = "db-f1-micro"
}

variable "project_id" {
  description = "Project/Subscription ID"
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

variable "network_cidr" {
  description = "CIDR block for database network access"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "Tags to apply to database resources"
  type        = map(string)
  default     = {}
}
