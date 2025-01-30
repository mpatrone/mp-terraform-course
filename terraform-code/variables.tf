variable "repo_max" {
  type        = number
  description = "maximum number of repositories"
  default     = 2

  validation {
    condition     = var.repo_max < 10
    error_message = "Number of repositories must be < 10"
  }
}

variable "env" {
  type        = string
  description = "The type of environment to be created. Must be wither 'dev' or 'prod'"
  default     = "dev"


  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "Environment must be either 'dev' or 'prod'"
  }
}

variable "repos" {
  type        = map(map(string))
  description = "repos"

  validation {
    condition     = length(var.repos) <= var.repo_max
    error_message = "Number of repositories cannot exceed repo_max"
  }
}