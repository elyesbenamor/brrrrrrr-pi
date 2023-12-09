
locals {
  computed_path = var.path == "kv" ? "kv" : "${var.path}/kv"
}

resource "vault_mount" "kvv2" {
  path        = local.computed_path
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
  lifecycle {
    prevent_destroy = true 
  }
}
