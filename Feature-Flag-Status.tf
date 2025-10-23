variable "feature" {
  default = "chat"
}

locals {
  feature_flags = {
    chat   = true
    search = false
  }

  status = lookup(local.feature_flags, var.feature, false) ? "enabled" : "disabled"
}

output "feature_status" {
  value = local.status
}
