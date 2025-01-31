repo_max = 2
env      = "dev"
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