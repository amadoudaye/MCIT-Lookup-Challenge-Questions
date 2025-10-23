variable "lang" {
  default = "fr"
}

locals {
  greetings = {
    en = { hello = "Hello" }
    fr = { hello = "Bonjour" }
    es = { hello = "Hola" }
  }

  greeting = lookup(lookup(local.greetings, var.lang, {}), "hello", "Hi")
}

output "greeting" {
  value = local.greeting
}
