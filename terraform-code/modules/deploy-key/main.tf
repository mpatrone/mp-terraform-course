variable "repo-name" {}

# ED25519 key
resource "tls_private_key" "pk" {
  algorithm = "ED25519"
}

# Add the ssh key as a deploy key
resource "github_repository_deploy_key" "this" {
  title      = "${var.repo-name}-key"
  repository = var.repo-name
  key        = tls_private_key.pk.public_key_openssh
  read_only  = true
}

resource "local_file" "this" {
  content  = tls_private_key.pk.private_key_openssh
  filename = "${path.cwd}/${github_repository_deploy_key.this.title}.pem"

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ${self.filename}"
  }
}