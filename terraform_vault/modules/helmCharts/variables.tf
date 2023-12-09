variable "release_name" {
  type = string
  description = "Helm chart release name"
  
}
variable "release_version" {
  type = string
  description = "Helm release version"
  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+$", var.release_version))
    error_message = "Invalid version format. It should follow the pattern '0.27.0'."
  }
}
variable "repository" {
  type = string
  description = "Helm chart repository"

}
variable "chart" {
  type = string
  description = "Chart name"
}
variable "namespace" {
  type = string
  description = "Namespace where helm is installed"
}
variable "initiate_namespace" {
  type = bool
  default = false
  description = "If true helm wil create the namespace if not existing"
}
variable "purge_process" {
  type = bool
  default = false
  description = "If true it will purge the installation if failed"
}
variable "set" {
  description = "List of settings to configure."
  type        = list(object({
    name  = string
    value = string
  }))
}
variable "values" {
  type = list(string)
  default = [ ]
}