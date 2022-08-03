terraform {
  required_providers {
    google = {
      version = "~> 4.30.0"
    }
  }
}

resource "google_sql_database_instance" "pg" {
  name                = "${var.project_name}-${var.environment}-pg"
  database_version    = var.database_version
  region              = var.gcp_region
  deletion_protection = false
  settings {
    tier = "db-f1-micro"
  }
}
