//vault read auth/root/role/root/role-id
//vault write -f --format=json auth/root/role/root/secret-id
module "root_approle" {
  source                = "./modules/approle"
  role_name             = "root"
  approle_path          = "root"
  token_max_approle_ttl = 31556952
  approle_token_ttl     = 31556952

  policy_content    = file("policies/root.hcl")
  vault_policy_name = "root-approle-policy"
}
//vault read auth/read-only/role/read-only/role-id
//vault write -f --format=json auth/read-only/role/read-only/secret-id
module "read_only_approle" {
  source                = "./modules/approle"
  role_name             = "read-only"
  approle_path          = "read-only"
  token_max_approle_ttl = 31556952
  approle_token_ttl     = 31556952

  policy_content    = file("policies/read-only.hcl")
  vault_policy_name = "read-only-approle-policy"
}
module "minio_secret" {
  source    = "./modules/secrets"
}

module "minio_vault_secrets" {
  source = "./modules/vault"
  path = "kubernetes"
  type = "kv-v2"
  name = "minio"
  data_json = {
    root_user       = "minio",
    root_password       = base64encode(module.minio_secret.generated_secrets)
  }
}
module "grafana_secret" {
  source    = "./modules/secrets"
}

module "grafana_vault_secrets" {
  source = "./modules/vault"
  path = "kubernetes"
  create_resource = false
  type = "kv-v2"
  name = "kube_stack"
  data_json = {
    password       = base64encode(module.grafana_secret.generated_secrets)
  }
}