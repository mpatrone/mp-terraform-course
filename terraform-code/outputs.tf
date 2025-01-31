output "repos-main" {
  value       = { for k, v in module.repos : k => v.clone-urls }
  description = "Repository names"
}

output "repos-list" {
  value       = flatten([for k, v in module.repos : keys(v.clone-urls) if k == "dev"])
  description = "Repository names"
}