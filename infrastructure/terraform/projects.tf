### GCP Projects

resource "google_project" "kubi-cloud" {
  name            = "kubi"
  project_id      = var.gcp_kube_project_id
  billing_account = var.gcp_billing_account_id
  org_id          = var.gcp_org_id
  labels = {
    "managed-by" = "terraform"
    "department" = "infra"
    "group"      = "kube-cloud"
  }
}
