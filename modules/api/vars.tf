variable "gcp_region" {
  description = "The GCP region to deploy to (e.g. us-west1)"
  type        = string
}

variable "gcp_location" {
  description = "The location to deploy to (e.g. us)"
  type        = string
}

variable "project_name" {
  description = "The project name"
  type        = string
}

variable "environment" {
  description = "The environment of this code stag"
  type        = string
}
