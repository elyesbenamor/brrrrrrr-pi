
module "vault_keycloak" {
    providers = {
        vault = vault.vault-1
  }
  source = "./modules/policies"
  policy_name   = "all"
  file_name = file("policies/keycloak.hcl")
}
module "keycloak" {
   providers = {
        vault = vault.vault-1
  }
   source = "./modules/keycloak_oidc"
   auth_backend_path = var.auth_backend_path
   auth_backend_name = var.auth_backend_name
   oidc_config = var.oidc_config
   oidc_secret = var.oidc_secret
   jwt_auth_backend_config = var.jwt_auth_backend_config
   policies = [module.vault_keycloak.policy_name]
}