variable "list-iam-role" {
  type        = list(string)
  description = "List of role"
}

variable "project-id" {
  type        = string
  description = "Project ID where the role need to be apply"
}

variable "iam-member" {
  type        = string
  description = "Identities that will be granted the privilege"
}