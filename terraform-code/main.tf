resource "random_id" "random" {
  byte_length = 2
  count       = var.repo_count
}


resource "github_repository" "mtc_repo" {
  count       = var.repo_count
  name        = "mtc_repo-${random_id.random[count.index].dec}"
  description = "Sample repo create in Terraform"
  visibility  = "private"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  count               = var.repo_count
  repository          = github_repository.mtc_repo[count.index].name
  branch              = "main"
  file                = "README.md"
  content             = "# This repository is for infra developers"
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  count               = var.repo_count
  repository          = github_repository.mtc_repo[count.index].name
  branch              = "main"
  file                = "index.html"
  content             = "Hello Terraform!"
  overwrite_on_create = true
}

output "repos" {
  value       = { for i in github_repository.mtc_repo[*] : i.name => i.http_clone_url }
  description = "Repository names"
}
