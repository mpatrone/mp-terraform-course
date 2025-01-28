resource "github_repository" "mtc_repo" {
  name        = "mtc_repo"
  description = "Sample repo create in Terraform"
  visibility  = "private"
  auto_init   = true
}