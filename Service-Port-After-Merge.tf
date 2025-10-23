variable "service" {
  default = "db"
}

locals {
  base_ports = {
    web = 80
    api = 8080
  }

  custom_ports = {
    db = 3306
  }

  merged_ports = merge(local.base_ports, local.custom_ports)

  port = lookup(local.merged_ports, var.service, -1)
}

output "service_port" {
  value = local.port
}
