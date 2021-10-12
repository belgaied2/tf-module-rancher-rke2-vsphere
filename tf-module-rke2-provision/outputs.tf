output "kubeconfig" {
  value = data.external.kubeconfig.result.document
}