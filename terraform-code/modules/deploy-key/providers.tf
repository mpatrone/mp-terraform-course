terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.5.0"
    }

    tls = {
      source = "hashicorp/tls"
      version = "4.0.6"
    }
  }
}
