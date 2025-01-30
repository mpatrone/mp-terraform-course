# resource "random_id" "random" {
#   byte_length = 2
#   count       = var.repo_count
# }


resource "github_repository" "mtc_repo" {
  for_each    = var.repos
  name        = "mtc_repo-${each.key}"
  description = "Sample repo create in Terraform"
  visibility  = var.env == "prod" ? "private" : "public"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  for_each            = var.repos
  repository          = github_repository.mtc_repo[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = "# This ${var.env} repository is for infra developers"
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  for_each            = var.repos
  repository          = github_repository.mtc_repo[each.key].name
  branch              = "main"
  file                = "index.html"
  content             = "Hello Terraform!"
  overwrite_on_create = true
}

output "repos" {
  value       = { for k, v in var.repos : k => github_repository.mtc_repo[k].http_clone_url }
  description = "Repository names"
}
