### Project API

# Enable project APIs
module "kube-api" {
  source = "./modules/project-api"
  list-api = [
    "cloudresourcemanager",
    "cloudbilling",
    "iam",
    "compute",
    "storage",
    "container",
    "vpcaccess",
    "servicenetworking",
    "containerregistry"
  ]
  project-id = var.gcp_kube_project_id
  depends_on = [google_project.kubi-cloud]
}
