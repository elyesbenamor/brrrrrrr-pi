
module "openebs" {
  source = "./modules/helmCharts"
  release_name       = "openebs"
  values = []
  repository = "https://openebs.github.io/charts"
  chart      = "openebs"
  release_version    = "3.9.0"
  namespace = "openebs"
  initiate_namespace = true
  purge_process = true
  set = [
    {
      name  = "ndm.enabled"
      value = "false"
    },
    {
      name  = "ndmOperator.enabled"
      value = "false"
    },
    {
      name  = "apiserver.resources.limits.cpu"
      value = "1000m"
    },
    {
      name  = "apiserver.resources.limits.memory"
      value = "1Gi"
    },
    {
      name  = "provisioner.resources.limits.cpu"
      value = "1000m"
    },
    {
      name  = "provisioner.resources.limits.cpu"
      value = "1Gi"
    },
    {
      name  = "localprovisioner.hostpathClass.basePath"
      value = "/mnt/openebs"
    },
  ]
}