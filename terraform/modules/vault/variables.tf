variable "path" {
  default = ""
  type    = string
}
variable "type" {
  default = ""
  type    = string
}
variable "name" {
  default = ""
  type    = string
}
variable "data_json" {
  description = "JSON data for the secrets"
  type        = map(any)
}
variable "create_resource" {
  description = "Whether to create the resource"
  type        = bool
  default     = true
}
variable "default_mount_path" {
  description = "Default mount path to use when tuple is empty"
  type        = string
  default     = "kubernetes"
}
