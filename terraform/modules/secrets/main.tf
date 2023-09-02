resource "random_string" "generate" {
  length           = var.length
  special          = false
  override_special = "/+"
}
output "generated_secrets" {
  value = random_string.generate.result
}