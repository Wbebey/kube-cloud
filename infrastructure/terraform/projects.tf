
resource "google_project" "kubi-cloud" {
  name            = "kubi"
  project_id      = var.gcp-kube-project-id
  billing_account = var.gcp-billing-account-id
  org_id          = var.gcp-org-id
  labels = {
    "managed-by" = "terraform"
    "department" = "infra"
    "group"      = "kube-cloud"
  }
}