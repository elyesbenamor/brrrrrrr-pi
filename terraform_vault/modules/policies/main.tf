resource "vault_policy" "policy" {
  name           = var.policy_name
  policy         = var.file_name
}