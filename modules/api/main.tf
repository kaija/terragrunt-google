terraform {
  required_providers {
    google = {
      version = "~> 4.30.0"
    }
  }
}

resource "google_storage_bucket" "source" {
  provider                    = google-beta
  name                        = "${var.project_name}-gcf-source" # Every bucket name must be globally unique
  location                    = var.gcp_location
  uniform_bucket_level_access = true
}

resource "google_api_gateway_api" "api" {
  provider = google-beta
  api_id   = "api"
}

data "google_storage_bucket_object" "zip" {
  name   = "api/health.zip"
  bucket = google_storage_bucket.source.name
}

resource "google_cloudfunctions_function" "function" {
  provider    = google-beta
  name        = "${var.project_name}-${var.environment}-api"
  description = "${var.project_name} ${var.environment} api function"
  runtime     = "nodejs16"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.source.name
  source_archive_object = data.google_storage_bucket_object.zip.name
  trigger_http          = true
  entry_point           = "health"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
