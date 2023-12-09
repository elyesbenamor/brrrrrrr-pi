terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.11.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "3.23.0"
    }
  }
}
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kubernetes-admin@kubernetes"
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
provider "vault" {
  alias = "vault-transit"
  address = "xx"
  token = "xx"
}
provider "vault" {
  alias = "vault-1"
  address = "xx"
  token = "xx"
}