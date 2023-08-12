resource "vault_mount" "kvv2" {
  count = var.create_resource ? 1 : 0
  path        = var.path
  type        = var.type
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}


resource "vault_kv_secret_v2" "secret" {
  mount                      = length(vault_mount.kvv2) > 0 ? vault_mount.kvv2[0].path : var.default_mount_path
  name                       = var.name
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(var.data_json)
}
