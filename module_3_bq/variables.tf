variable "credential" {
    description         = "my credentials"
    default             = "../keys/vernal-foundry-375904-b157d14ca9d9.json"
}

variable "project" {
    description         = "project name"
    default             = "vernal-foundry-375904"
}

variable "region" {
    description         = "project region"
    default             = "us-central1"
}

variable "location" {
    description         = "project location"
    default             = "US"
}

variable "bq_dataset_name" {
    description         = "My Bigquery dataset name"
    default             = "demo_dataset"
}

variable "gcs_bucket_name" {
    description         = "Bucket Storage Name"
    default             = "vernal-foundry-375904-demo-bucket"
}

variable "gcs_m3_bucket_name" {
    description         = "Bucket Storage Name"
    default             = "vernal-foundry-375904-ny-taxi-data"
}


variable "gcs_storage_class" {
    description         = "Bucket Storage Class"
    default             = "STANDARD"
}