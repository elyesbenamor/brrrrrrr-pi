module "minio_secret" {
  source = "./modules/secrets"
  length = 128
}

module "minio_vault_secrets" {
  source = "./modules/vault"
  path   = "kubernetes"
  type   = "kv-v2"
  name   = "minio"
  data_json = {
    root_user     = "minio",
    root_password = base64encode(module.minio_secret.generated_secrets)
  }
}

module "grafana_secret" {
  source = "./modules/secrets"
  length = 128
}

module "grafana_vault_secrets" {
  source          = "./modules/vault"
  path            = "kubernetes"
  create_resource = false
  type            = "kv-v2"
  name            = "kube_stack"
  data_json = {
    password = base64encode(module.grafana_secret.generated_secrets)
  }
}

module "postgresql_secret" {
  source = "./modules/secrets"
  length = 15
}

module "postgresql_vault_secrets" {
  source          = "./modules/vault"
  path            = "kubernetes"
  create_resource = false
  type            = "kv-v2"
  name            = "postgresql"
  data_json = {
    postgresPassword = base64encode(module.postgresql_secret.generated_secrets)
    username         = base64encode(module.postgresql_secret.generated_secrets)
    database         = "postgres"
    password         = base64encode(module.postgresql_secret.generated_secrets)
  }
}
module "mysql_secret" {
  source = "./modules/secrets"
  length = 15
}

module "mysql_vault_secrets" {
  source          = "./modules/vault"
  path            = "kubernetes"
  create_resource = false
  type            = "kv-v2"
  name            = "mysql"
  data_json = {
    rootPassword = base64encode(module.mysql_secret.generated_secrets)
    username         = base64encode(module.mysql_secret.generated_secrets)
    database         = "mysql"
    replicationPassword = base64encode(module.mysql_secret.generated_secrets)
    password         = base64encode(module.mysql_secret.generated_secrets)
  }
}
module "semaphore_secret" {
  source = "./modules/secrets"
  length = 15
}
module "semaphore_db_secret" {
  source = "./modules/secrets"
  length = 15
}

module "semaphore_vault_secrets" {
  source          = "./modules/vault"
  path            = "kubernetes"
  create_resource = false
  type            = "kv-v2"
  name            = "semaphore"
  data_json = {
    username         = "admin"
    password         = base64encode(module.semaphore_secret.generated_secrets)
    databasepass  = base64encode(module.semaphore_db_secret.generated_secrets)
  }
}
module "ben_secret" {
  source = "./modules/secrets"
  length = 15
}

module "ben_minio_vault_secrets" {
  source          = "./modules/vault"
  path            = "minio_users/ebenamor"
  create_resource = true
  type            = "kv-v2"
  name            = "ebenamor"
  data_json = {
    username         = "ebenamor"
    password         = base64encode(module.ben_secret.generated_secrets)
  }
}
module "firas_secret" {
  source = "./modules/secrets"
  length = 15
}

module "firas_minio_vault_secrets" {
  source          = "./modules/vault"
  path            = "minio_users/firas"
  create_resource = true
  type            = "kv-v2"
  name            = "firas"
  data_json = {
    username         = "firas"
    password         = base64encode(module.firas_secret.generated_secrets)
  }
}