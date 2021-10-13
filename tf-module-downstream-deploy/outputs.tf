output "import_manifest" {
value = data.http.get_import_manifest.body
}

output "cluster_id" {
  value = rancher2_cluster.rke2_imported.id
}