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
  address = "http://192.168.1.167:32224"
  token = "hvs.gdVsRkk8rZZzNVpCwiSadW4P"
}
provider "vault" {
  alias = "vault-1"
  address = "http://192.168.1.249:32355"
  token = "hvs.K7KiA9VHM2HC2zFKRrcd2TUq"
}