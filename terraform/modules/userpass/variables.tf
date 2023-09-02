
variable "vault_policy_name" {
  type = string
  default = ""
}
variable "policy_content" {
  description = "Content of the Vault policy"
  type        = string
  default     = ""
}

variable "user_names" {
  type    = list(string)
  default = []
}
variable "user_passwords" {
  type    = map(string)
  default = {}
}
