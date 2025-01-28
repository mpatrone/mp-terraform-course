terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.5.0"
    }
  }
}

provider "github" {
  # Configuration options
  owner = "mpatrone"
}