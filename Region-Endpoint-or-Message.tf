variable "selected_region" {
  default = "africa"
}

locals {
  endpoints = {
    us = "us.example.com"
    eu = "eu.example.com"
  }

  endpoint = lookup(local.endpoints, var.selected_region, "Unsupported region: ${var.selected_region}")
}

output "region_message" {
  value = local.endpoint
}
