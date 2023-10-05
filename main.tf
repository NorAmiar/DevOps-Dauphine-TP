resource "google_project_service" "ressource_manager" {
    service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "ressource_usage" {
    service = "serviceusage.googleapis.com"
    depends_on = [ google_project_service.ressource_manager ]
}

resource "google_project_service" "artifact" {
    service = "artifactregistry.googleapis.com"
    depends_on = [ google_project_service.ressource_manager ]
}

resource "google_artifact_registry_repository" "my-repo" {
  location      = "us-west2"
  repository_id = "session4-repo"
  description   = "Exemple de repo Docker"
  format        = "DOCKER"
}

#CREATION DE LA RESSOURCE CLOUD RUN

resource "google_cloud_run_service" "my-cloud-run-service" {
  name     = "my-cloud-run-service"
  location = "us-west2"  # Remplacez par la région souhaitée

  template {
    spec {
      containers {
        image = "us-west2-docker.pkg.dev/basic-lock-349116/session4-repo/session4-image"
        ports {
          container_port = 80
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}