resource "vault_auth_backend" "approle" {
  type           = var.type
}
resource "vault_approle_auth_backend_role" "approle" {
  token_ttl             = var.token_ttl
  token_max_ttl         = var.token_max_ttl
  backend               = vault_auth_backend.approle.path
  role_name             = var.role_name
  token_policies        = var.token_policies
}