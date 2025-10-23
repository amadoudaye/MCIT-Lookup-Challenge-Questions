##########################
# 1. Plan Quota
##########################
variable "plan_quota_plan" {
  default = "pro"
}

locals {
  plan_quota_map = {
    free       = 10
    pro        = 100
    enterprise = 1000
  }

  plan_quota_result = lookup(local.plan_quota_map, var.plan_quota_plan, 0)
}

output "plan_quota_result" {
  value = local.plan_quota_result
}

##########################
# 2. Region Endpoint with Secondary Fallback
##########################
variable "region_fallback_region" {
  default = "asia"
}

locals {
  region_fallback_primary = {
    us = "us.api.example.com"
    eu = "eu.api.example.com"
  }

  region_fallback_secondary = {
    asia = "asia-alt.api.example.com"
  }

  region_fallback_endpoint = lookup(
    local.region_fallback_primary,
    var.region_fallback_region,
    lookup(local.region_fallback_secondary, var.region_fallback_region, "not-available")
  )
}

output "region_fallback_endpoint" {
  value = local.region_fallback_endpoint
}

##########################
# 3. Nested Greeting Lookup
##########################
variable "nested_greeting_lang" {
  default = "fr"
}

locals {
  nested_greeting_map = {
    en = { hello = "Hello" }
    fr = { hello = "Bonjour" }
    es = { hello = "Hola" }
  }

  nested_greeting_result = lookup(
    lookup(local.nested_greeting_map, var.nested_greeting_lang, {}),
    "hello",
    "Hi"
  )
}

output "nested_greeting_result" {
  value = local.nested_greeting_result
}

##########################
# 4. Airport Codes for Requested Cities
##########################
variable "airport_cities" {
  default = ["Toronto", "Paris", "Dakar"]
}

locals {
  airport_codes_map = {
    Toronto = "YYZ"
    Paris   = "CDG"
    London  = "LHR"
  }

  airport_codes_result = [for city in var.airport_cities : lookup(local.airport_codes_map, city, "XXX")]
}

output "airport_codes_result" {
  value = local.airport_codes_result
}

##########################
# 5. Environment Presence Check
##########################
variable "env_check" {
  default = "stage"
}

locals {
  env_map = {
    dev   = "Development"
    qa    = "Quality Assurance"
    prod  = "Production"
  }

  env_check_result = lookup(local.env_map, var.env_check, "Missing") != "Missing" ? "Exists" : "Missing"
}

output "env_check_result" {
  value = local.env_check_result
}

##########################
# 6. Region Endpoint or Message
##########################
variable "region_message_region" {
  default = "africa"
}

locals {
  region_message_map = {
    us = "us.api.example.com"
    eu = "eu.api.example.com"
  }

  region_message_result = lookup(local.region_message_map, var.region_message_region, "Unsupported region: ${var.region_message_region}")
}

output "region_message_result" {
  value = local.region_message_result
}

##########################
# 7. Service Port After Merge
##########################
variable "service_port_service" {
  default = "cache"
}

locals {
  base_ports = {
    web   = 80
    db    = 3306
  }

  custom_ports = {
    cache = 6379
  }

  merged_ports = merge(local.base_ports, local.custom_ports)

  service_port_result = lookup(local.merged_ports, var.service_port_service, -1)
}

output "service_port_result" {
  value = local.service_port_result
}

##########################
# 8. Case-Insensitive Country Code
##########################
variable "country_input" {
  default = "usa"
}

locals {
  country_codes = {
    "usa" = "US"
    "canada" = "CA"
    "mexico" = "MX"
  }

  country_code_result = lookup(local.country_codes, lower(var.country_input), "UNKNOWN")
}

output "country_code_result" {
  value = local.country_code_result
}

##########################
# 9. Product Price with Multi-Map Fallbacks
##########################
variable "product_region" {
  default = "asia"
}

variable "product_name" {
  default = "laptop"
}

locals {
  regional_prices = {
    us = { laptop = 1000, phone = 600 }
    eu = { laptop = 1200, phone = 700 }
  }

  global_prices = {
    laptop = 900
    phone  = 500
  }

  product_price_result = lookup(
    lookup(local.regional_prices, var.product_region, {}),
    var.product_name,
    lookup(local.global_prices, var.product_name, -1)
  )
}

output "product_price_result" {
  value = local.product_price_result
}

##########################
# 10. Feature Flag Status
##########################
variable "feature_flag" {
  default = "chat"
}

locals {
  feature_flags_map = {
    chat   = true
    search = false
  }

  feature_flag_result = lookup(local.feature_flags_map, var.feature_flag, false) ? "enabled" : "disabled"
}

output "feature_flag_result" {
  value = local.feature_flag_result
}
