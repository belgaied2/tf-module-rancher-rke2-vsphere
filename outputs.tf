output "upstream_kubeconfig" {
  value = module.rke2-upstream-provision.kubeconfig
}

output "downstream_kubeconfig" {
  value = module.rke2-downstream-provision.kubeconfig
}

# output "downstream_host" {
#   value = module.rke2-downstream-provision.kubeconfig.clusters[0].cluster.server
# }

output "downstream_import_manifest" {
  value = module.rke2-downstream-import-cluster.import_manifest
}