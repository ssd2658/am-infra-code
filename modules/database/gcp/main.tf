resource "google_sql_database_instance" "postgres" {
  name             = var.database_name
  database_version = var.database_version
  region           = var.region

  settings {
    tier = var.instance_type
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "allow-all"
        value = "0.0.0.0/0"
      }
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "admin" {
  name     = var.admin_username
  instance = google_sql_database_instance.postgres.name
  password = var.admin_password
}

# Outputs
output "database_endpoint" {
  value     = google_sql_database_instance.postgres.public_ip_address
  sensitive = true
}
