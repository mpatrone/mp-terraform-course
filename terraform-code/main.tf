locals {
  repos = {
    backend = {
      lang     = "python"
      filename = "main.py"
      pages    = true
    },
    infra = {
      lang     = "terraform"
      filename = "main.tf"
      pages    = true
    },
    frontend = {
      lang     = "javascript"
      filename = "main.js"
      pages    = false
    }
  }
  environments = toset(["prod"])
}

module "repos" {
  source   = "./modules/dev-repos"
  for_each = local.environments
  repo_max = 9
  env      = each.key
  repos    = local.repos
}

module "keys" {
  source    = "./modules/deploy-key"
  for_each  = toset(flatten([for k, v in module.repos : keys(v.clone-urls) if k == "dev"]))
  repo-name = each.key
}

module "info-page" {
  source = "./modules/info-page"
  repos  = { for k, v in module.repos["prod"].clone-urls : k => v }
}

output "repo-list" {
  value       = flatten([for k, v in module.repos : keys(v.clone-urls)])
  description = "Repository names"
}