resource "google_project_service" "enable-api" {
  for_each           = toset(var.list-api)
  service            = "${each.value}.googleapis.com"
  project            = var.project-id
  disable_on_destroy = true
}
