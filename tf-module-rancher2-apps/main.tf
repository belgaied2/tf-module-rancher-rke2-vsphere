

resource "rancher2_app_v2" "rancher_monitor" {

  for_each = toset(var.apps)
  provider = rancher2.rancher
  cluster_id = "local"
  name = each.key
  namespace = each.key
  repo_name = "rancher-charts"
  chart_name = each.key
  chart_version = "14.5.100"
  values = file("${path.module}/value-yamls/rancher-monitoring-values.yaml")
}