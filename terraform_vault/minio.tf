module "minio" {

  source = "./modules/helmCharts"
  release_name       = "minio"
  values = [ "${file("./policies/minio.yaml")}" ]
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "minio"
  release_version    = "12.10.3"
  namespace = "minio"
  initiate_namespace = true
  purge_process = true
  set = [
    
  ]
}