
variable "default_lease_ttl_seconds" {
  type = number
  default = 7800 
  description = "THe token time to live"
}
variable "max_lease_ttl_seconds" {
  type = number
  default = 2638288 
  description = "the max token time to live, how long we can renew the token"
}
variable "auth_backend_path" {
  default = "oidc"
}
variable "auth_backend_name" {
  default = "oidc"
}
variable "oidc_config" {
  default = {
    "oidc_discovery_url" = "http://192.168.1.196:32563/realms/vault"
    "oidc_client_id" = "vault"
  }
}
variable "oidc_secret" {
  type = string
}
variable "jwt_auth_backend_config" {
  default = {
    role_name = "default"
    role_type = "oidc"
    token_ttl = 3600
    token_max_ttl =3600
    bound_audiences = ["vault"]
    claim_mappings = {
      preferred_username = "username"
      email              = "email"
    }
    allowed_redirect_uris = [
      "http://172.30.91.197:8200/ui/vault/auth/oidc/oidc/callback",    
      "http://172.30.91.197:8200/oidc/callback",
      "http://192.168.1.249:32355/oidc/callback",
      "http://192.168.1.249:32355/ui/vault/auth/oidc/oidc/callback"
  ]
  groups_claim = "/resource_access/vault/roles"
  }
}
