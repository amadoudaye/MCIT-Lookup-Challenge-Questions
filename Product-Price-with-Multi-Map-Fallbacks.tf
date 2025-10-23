variable "region" {
  default = "eu"
}

variable "product" {
  default = "laptop"
}

locals {
  regional_prices = {
    us = { laptop = 900 }
    eu = { phone = 600 }
  }

  global_prices = {
    laptop = 950
    phone  = 700
  }

  price = lookup(
    lookup(local.regional_prices, var.region, {}),
    var.product,
    lookup(local.global_prices, var.product, -1)
  )
}

output "product_price" {
  value = local.price
}
