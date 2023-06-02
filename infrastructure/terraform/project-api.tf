### Project API

# Enable project APIs
module "kube-api" {
  source     = "./modules/project-api"
  list-api   = ["cloudresourcemanager", "cloudbilling", "iam", "compute", "storage"]
  project-id = var.gcp_kube_project_id
}
