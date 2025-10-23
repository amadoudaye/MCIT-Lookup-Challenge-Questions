variable "country_input" {
  default = "UsA"
}

locals {
  countries = {
    "usa" = "US"
    "canada" = "CA"
    "france" = "FR"
  }

  normalized_input = lower(var.country_input)
  code = lookup(local.countries, local.normalized_input, "UNKNOWN")
}

output "country_code" {
  value = local.code
}
