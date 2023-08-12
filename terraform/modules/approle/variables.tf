variable "role_name" {
  type = string
  default = ""
}
variable "approle_path" {
  type = string
  default = ""
}

variable "token_max_approle_ttl" {
  type = number
  default = 0
}

variable "token_num_uses" {
  type = number
  default = 0
}
variable "vault_policy_name" {
  type = string
  default = ""
}
variable "approle_token_ttl" {
  type = number
  default = 0
}
variable "policy_content" {
  description = "Content of the Vault policy"
  type        = string
  default     = ""
}