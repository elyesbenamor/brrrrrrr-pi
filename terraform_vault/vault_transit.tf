
module "vault_transit" {
  source = "./modules//helmCharts"
  release_name       = "vault"
  values = []
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  release_version    = "0.27.0"
  namespace = "vault-transit"
  initiate_namespace = true
  purge_process = true
  set = [
    {
      name  = "ui.enabled"
      value = "true"
    },
    {
      name  = "ui.serviceType"
      value = "NodePort"
    },
    {
      name  = "server.resources.limits.memory"
      value = "256Mi"
    },
    {
      name  = "injector.injector.enabled"
      value = "true"
    },
    {
      name  = "server.resources.limits.cpu"
      value = "250m"
    },
    {
      name  = "server.dataStorage.storageClass"
      value = "openebs-hostpath"
    },
    {
      name  = "server.dataStorage.size"
      value = "2Gi"
    },
    {
      name  = "server.auditStorage.enabled"
      value = "false"
    }
  ]
  depends_on = [module.openebs]
}
module "transit_policy" {
    providers = {
        vault = vault.vault-transit
  }
  source = "./modules/policies"
  policy_name   = "transit"
  file_name = file("policies/transit.hcl")
}

resource "vault_mount" "transit" {
  provider = vault.vault-transit
  path                      = "transit/vault-1"
  type                      = "transit"
  description               = "Transit for vault-1"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

resource "vault_transit_secret_backend_key" "key" {
  backend = vault_mount.transit.path
  name    = "vault-1"
  provider = vault.vault-transit
}