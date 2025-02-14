variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "region" {
  description = "Cloud region for the cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the cluster"
  type        = number
  default     = 3
}

variable "node_type" {
  description = "Machine type/size for cluster nodes"
  type        = string
  default     = "standard"
}

variable "network_cidr" {
  description = "CIDR block for cluster network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_id" {
  description = "Project/Subscription ID"
  type        = string
}

variable "tags" {
  description = "Tags to apply to cluster resources"
  type        = map(string)
  default     = {}
}
