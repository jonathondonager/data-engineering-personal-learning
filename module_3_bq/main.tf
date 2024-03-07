terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.14.0"
    }
  }
}

provider "google" {
  credentials = file(var.credential)
  project     = var.project
  region      = var.region
}

resource "google_storage_bucket" "ny_taxi_data" {
  name          = var.gcs_m3_bucket_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 14
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "ny_taxi_data" {
  dataset_id                  = "ny_taxi_data"
  friendly_name               = "ny_taxi"
  description                 = "holding parquet files for external bq table"
  location                    = var.location
  delete_contents_on_destroy  = true
  project                     = var.project

}

