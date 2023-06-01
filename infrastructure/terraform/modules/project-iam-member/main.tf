resource "google_project_iam_member" "grant-role" {
  for_each = toset(var.list-iam-role)
  role     = each.value
  project  = var.project-id
  member   = var.iam-member
}
