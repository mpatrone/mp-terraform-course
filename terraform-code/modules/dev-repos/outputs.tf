output "clone-urls" {
  value = { for i in github_repository.mtc_repo : i.name => {
    ssh-clone-url  = i.ssh_clone_url,
    http-clone-url = i.http_clone_url,
    pages-url      = try(i.pages[0].html_url, "nopage")
    }
  }
  description = "Repository names"
}