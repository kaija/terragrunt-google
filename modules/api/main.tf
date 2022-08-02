terraform {
  required_providers {
    google = {
      version = "~> 4.30.0"
    }
  }
}

resource "google_storage_bucket" "bucket" {
  name     = "cloudfunctions2-function-bucket-demo"  # Every bucket name must be globally unique
  location = "US"
  uniform_bucket_level_access = true
}
