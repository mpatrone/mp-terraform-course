# resource "random_id" "random" {
#   byte_length = 2
#   count       = var.repo_count
# }

data "github_user" "current" {
  username = ""
}

resource "github_repository" "mtc_repo" {
  for_each    = var.repos
  name        = "mtc_repo-${each.key}"
  description = "Sample repo created in Terraform"
  visibility  = var.env == "prod" ? "private" : "public"
  auto_init   = true

  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf ${self.name}"
  }
}

resource "terraform_data" "repo-clone" {
  for_each   = var.repos
  depends_on = [github_repository_file.readme, github_repository_file.index]

  provisioner "local-exec" {
    command = "gh repo clone ${github_repository.mtc_repo[each.key].name}"
  }
}

resource "github_repository_file" "readme" {
  for_each            = var.repos
  repository          = github_repository.mtc_repo[each.key].name
  branch              = "main"
  file                = "README.md"
  content             = <<-EOF
                        # This is a ${var.env} ${each.value.lang} for ${each.key} developers.
                        Last modified by ${data.github_user.current.name}"
                        EOF
  overwrite_on_create = true

  # lifecycle {
  #   ignore_changes = [content]
  # }
}

resource "github_repository_file" "index" {
  for_each            = var.repos
  repository          = github_repository.mtc_repo[each.key].name
  branch              = "main"
  file                = each.value.filename
  content             = "Hello ${each.value.lang}!"
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [content]
  }
}

output "repos" {
  value       = { for i in github_repository.mtc_repo : i.name => [i.ssh_clone_url, i.http_clone_url] }
  description = "Repository names"
}
