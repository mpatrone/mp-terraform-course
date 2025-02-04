resource "github_repository" "this" {
  name        = "mtc-info-page"
  description = "Sample info page repo"
  visibility  = "public" # Github restrictions on enabling Pages on private repos
  auto_init   = true
  pages {
    source {
      branch = "main"
      path   = "/"
    }
  }
  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }
}

data "github_user" "current" {
    username = ""
}

resource "time_static" "this" {}

resource "github_repository_file" "this" {
  repository = github_repository.this.name
  branch     = "main"
  file       = "index.md"
  content = templatefile("${path.module}/templates/index.tftpl", {
    avatar = data.github_user.current.avatar_url,
    name   = data.github_user.current.name,
    date   = time_static.this.year
  })
}