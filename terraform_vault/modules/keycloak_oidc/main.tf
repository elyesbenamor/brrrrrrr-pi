resource "vault_identity_oidc_key" "keycloak_provider_key" {
  name      = "keycloak"
  algorithm = "RS256"
}
resource "vault_jwt_auth_backend" "keycloak" {
  path               = var.auth_backend_path
  type               = var.auth_backend_name
  default_role       = "default"
  oidc_discovery_url = var.oidc_config.oidc_discovery_url
  oidc_client_id  =  var.oidc_config.oidc_client_id
  oidc_client_secret = var.oidc_secret

  tune {
    audit_non_hmac_request_keys  = []
    audit_non_hmac_response_keys = []
    default_lease_ttl            = "1h"
    listing_visibility           = "unauth"
    max_lease_ttl                = "1h"
    passthrough_request_headers  = []
    token_type                   = "default-service"
  }
}
resource "vault_jwt_auth_backend_role" "default" {
  backend        = vault_jwt_auth_backend.keycloak.path
  role_name      = var.jwt_auth_backend_config.role_name
  role_type      = var.jwt_auth_backend_config.role_type
  token_ttl      = var.jwt_auth_backend_config.token_ttl
  token_max_ttl  = var.jwt_auth_backend_config.token_max_ttl

  bound_audiences = var.jwt_auth_backend_config.bound_audiences
  user_claim      = "sub"
  claim_mappings = var.jwt_auth_backend_config.claim_mappings

  allowed_redirect_uris = var.jwt_auth_backend_config.allowed_redirect_uris
  groups_claim = var.jwt_auth_backend_config.groups_claim
}

resource "vault_identity_oidc_role" "all_role" {
  name = "all"
  key  = vault_identity_oidc_key.keycloak_provider_key.name
}

resource "vault_identity_group" "group" {
  name     = vault_identity_oidc_role.all_role.name
  type     = "external"
  policies = var.policies
}
resource "vault_identity_group_alias" "group_alias" {
  name           = "all"
  mount_accessor = vault_jwt_auth_backend.keycloak.accessor
  canonical_id   = vault_identity_group.group.id
}