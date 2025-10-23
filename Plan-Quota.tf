variable "selected_plan" {
  default = "pro"
}

locals {
  plan_quota = {
    free       = 10
    pro        = 100
    enterprise = 1000
  }

  quota = lookup(local.plan_quota, var.selected_plan, 0)
}

output "plan_quota" {
  value = local.quota
}
