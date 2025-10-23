variable "env" {
  default = "qa"
}

locals {
  environments = {
    dev  = "Development"
    prod = "Production"
  }

  exists = lookup(local.environments, var.env, "__MISSING__") != "__MISSING__" ? "Exists" : "Missing"
}

output "environment_status" {
  value = local.exists
}
