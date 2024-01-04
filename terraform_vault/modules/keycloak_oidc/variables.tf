variable "auth_backend_path" {
  type = string
}
variable "auth_backend_name" {
  type = string
}
variable "oidc_config" {
  type = map(string)
}
variable "oidc_secret" {
  type = string
}
variable "jwt_auth_backend_config" {
  type = object({
    role_name             = string
    role_type             = string
    token_ttl             = number
    token_max_ttl         = number
    bound_audiences       = list(string)
    claim_mappings        = map(string)
    allowed_redirect_uris = list(string)
    groups_claim          = string
  })
}
variable "policies" {
  type = list(string)
}
