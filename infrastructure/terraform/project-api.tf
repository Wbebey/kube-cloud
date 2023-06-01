module "kube-api" {
  source     = "./modules/project-api"
  list-api   = ["cloudresourcemanager", "cloudbilling", "iam", "compute", "storage"]
  project-id = var.gcp-kube-project-id
}