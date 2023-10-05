terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.10"
    }
  }

   backend "gcs" {
       bucket = "tpexamen-401106-tfstate"
  }

  required_version = ">= 1.0"
}


provider "google" {
    project = "tpexamen-401106"
}