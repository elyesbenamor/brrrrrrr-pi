resource "random_string" "generate" {
  length           = 128
  special          = false
  override_special = "/+"
}
output "generated_secrets" {
  value = random_string.generate.result
}