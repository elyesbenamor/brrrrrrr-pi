resource "vault_mount" "kvv2" {
  path        = var.path
  type        = var.type
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

resource "vault_kv_secret_v2" "example" {
  mount                      = vault_mount.kvv2.path
  name                       = var.name
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(
  {
    zip       = base64encode(random_string.generate.result),
    foo       = base64encode(random_string.generate.result)
  }
  )
}
module "local_chart" {
  source    = "./secrets"
}
