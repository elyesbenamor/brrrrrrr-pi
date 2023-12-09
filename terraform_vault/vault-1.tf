
module "vault_1" {
  source = "./modules//helmCharts"
  release_name       = "vault"
  values = ["${file("./policies/values.yaml")}"]
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  release_version    = "0.27.0"
  namespace = "vault-1"
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
      name  = "injector.injector.enabled"
      value = "true"
    },
    {
      name  = "server.resources.limits.memory"
      value = "256Mi"
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
      value = "10Gi"
    },
    {
      name  = "server.auditStorage.enabled"
      value = "false"
    }
  ]
  depends_on = [module.openebs]
}

resource "vault_audit" "audit-1" {
  provider = vault.vault-1
  type = "file"

  options = {
    file_path = "/vault/data/audit.log"
  }
}
module "grafana" {
  source = "./modules/vault"
  path   = "kube-stack"
  providers = {
        vault = vault.vault-1
  }
  
}
module "prometheus" {
    providers = {
        vault = vault.vault-1
  }
  source = "./modules/policies"
  policy_name   = "prometheus"
  file_name = file("policies/prometheus.hcl")
}
module "vaul_agent" {
    providers = {
        vault = vault.vault-1
  }
  source = "./modules/policies"
  policy_name   = "snapshot"
  file_name = file("policies/vault-agent.hcl")
}
module "vader_auth" {
  source = "./modules/vault_auth"
  role_name = module.vaul_agent.policy_name
  token_policies    = ["default",module.vaul_agent.policy_name]
  token_ttl = var.default_lease_ttl_seconds
  token_max_ttl = var.max_lease_ttl_seconds
  type = "approle"
  providers = {
        vault = vault.vault-1
  }
}