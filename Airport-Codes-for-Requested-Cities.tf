variable "requested_cities" {
  default = ["Toronto", "Paris", "Dakar"]
}

locals {
  airports = {
    Toronto = "YYZ"
    Paris   = "CDG"
  }

  airport_codes = [for city in var.requested_cities : lookup(local.airports, city, "XXX")]
}

output "airport_codes" {
  value = local.airport_codes
}
