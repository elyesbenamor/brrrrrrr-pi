resource "vault_auth_backend" "userpass" {
  provider       = vault
  type = "userpass"
}
resource "vault_policy" "root" {
  provider       = vault
  name           = var.vault_policy_name
  policy         = var.policy_content
}
resource "vault_generic_endpoint" "user" {
  depends_on = [ vault_auth_backend.userpass ]
  for_each = toset(var.user_names)
  path                 = "auth/userpass/users/${each.key}"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["default", vault_policy.root.name]
    password = var.user_passwords[each.key]
    username = each.key
  })
}
