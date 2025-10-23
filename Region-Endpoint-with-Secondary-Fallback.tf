variable "region" {
  default = "asia"
}

locals {
  region_endpoints = {
    us = "us.example.com"
    eu = "eu.example.com"
  }

  override_endpoints = {
    asia = "asia-alt.example.com"
  }

  endpoint = lookup(
    local.region_endpoints,
    var.region,
    lookup(local.override_endpoints, var.region, "not-available")
  )
}

output "region_endpoint" {
  value = local.endpoint
}
