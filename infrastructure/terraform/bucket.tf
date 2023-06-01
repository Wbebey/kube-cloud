# ### gcs 

# resource "google_storage_bucket" " test-bucket" {
#   name          = "test-bucket"
#   location      = var.gcp-region
#   force_destroy = true
#   project       = var.gcp-kube-project-id
# }