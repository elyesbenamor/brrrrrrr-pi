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


module "user_secret" {
  source = "./modules/secrets"
  length = 20
}
module "userpass" {
  source            = "./modules/userpass"
  policy_content    = file("policies/root.hcl")
  vault_policy_name = "user-root-approle-policy"
  user_names        = ["firas", "ebenamor"]
  user_passwords = {
    "firas"    = base64encode(module.user_secret.generated_secrets)
    "ebenamor" = base64encode(module.user_secret.generated_secrets)
  }
}
