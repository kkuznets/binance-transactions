terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
}

resource "google_artifact_registry_repository" "my-repo" {
  location      = var.gcp_region
  repository_id = var.ar_repository
  description   = "Repo for Prefect agent docker images"
  format        = "DOCKER"
}

resource "google_storage_bucket" "data-lake-bucket" {
  name                        = var.bucket_name
  location                    = var.data_location
  uniform_bucket_level_access = true
  force_destroy               = true
  versioning {
    enabled = true
  }
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                 = var.dataset_name
  location                   = var.data_location
  friendly_name              = "Crypto Data"
  description                = "Dataset for crypto market analysis"
  delete_contents_on_destroy = true
}
