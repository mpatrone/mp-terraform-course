repo_max = 10
env      = "prod"
repos = {
  backend = {
    lang     = "python"
    filename = "main.py"
    pages    = true
  },
  infra = {
    lang     = "terraform"
    filename = "main.tf"
    pages    = false
  }
}