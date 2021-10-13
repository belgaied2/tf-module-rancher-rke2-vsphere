resource "rancher2_cluster" "rke2_imported" {
  # provider = rancher2.rancher
  name = var.app_cluster_name
  description = var.app_cluster_description
}


data "http" "get_import_manifest" {
  url = rancher2_cluster.rke2_imported.cluster_registration_token[0].manifest_url
}

# resource "kubernetes_manifest" "import_command" {
#   manifest = yamldecode(data.http.get_import_manifest.body)
# }

data "kubectl_file_documents" "splitted_manifests" {
  content = data.http.get_import_manifest.body
}


resource "kubectl_manifest" "import_commmand" {
  for_each = data.kubectl_file_documents.splitted_manifests.manifests
  yaml_body = each.value
}

# resource "local_file" "kubeconfig" {
#   content = var.kubeconfig
#   filename = "${path.module}/downstream_kubeconfig.yaml"
# }

# resource "null_resource" "kubectl_apply" {
#   provisioner "local-exec" {
#     command = "kubectl --kubeconfig ${path.module}/downstream_kubeconfig.yaml apply -f ${rancher2_cluster.rke2_imported.cluster_registration_token[0].manifest_url}"
#   }
# }