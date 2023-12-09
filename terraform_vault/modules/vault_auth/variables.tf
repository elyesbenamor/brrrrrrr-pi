variable "type" {
  type = string
  description = "auth method type"
}
variable "token_ttl" {
  type = number
  default = 7200 # 2h
  description = "THe token time to live"
}
variable "token_max_ttl" {
  type = number
  default = 2628288 # 1 month
  description = "the max token time to live, how long we can renew the token"
}
variable "role_name" {
  type = string
  description = "approle name"
}

variable "token_policies" {
  type = list(string)
  description = "list of policies atatched"
}