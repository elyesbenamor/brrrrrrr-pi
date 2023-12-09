resource "helm_release" "helm_chart" {
  version    = var.release_version

  name       = var.release_name
  repository = var.repository
  chart      = var.chart
  namespace = var.namespace
  create_namespace = var.initiate_namespace
  atomic = var.purge_process

  dynamic "set" {
    for_each = var.set
    content {
      name  = set.value.name
      value = set.value.value
    }
  }
  values = var.values
}
