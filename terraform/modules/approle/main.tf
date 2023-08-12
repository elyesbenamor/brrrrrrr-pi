resource "vault_auth_backend" "approle" {
  type = "approle"
  path = var.approle_path
}

resource "vault_policy" "root" {
  provider       = vault
  name           = var.vault_policy_name
  policy         = var.policy_content
}
resource "vault_approle_auth_backend_role" "approle" {
  provider       = vault
  backend        = vault_auth_backend.approle.path
  role_name      = var.role_name
  token_ttl     = var.approle_token_ttl
  token_max_ttl = var.token_max_approle_ttl 
  token_num_uses  = var.token_num_uses
  token_policies        = ["default", vault_policy.root.name]
  
}