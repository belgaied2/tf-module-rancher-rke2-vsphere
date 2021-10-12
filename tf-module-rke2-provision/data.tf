resource "local_file" "script_kubeconfig" {
  content = templatefile("${path.module}/file_templates/get_kubeconfig.sh.tpl",{ ssh_user = var.ssh_user, vm_ip = var.vm_ips[0]})
  filename = "${path.module}/get_kubeconfig.sh"
  depends_on = [
    null_resource.rke2_server1_provisioning
  ]
}

data "external" "kubeconfig" {
  program = [
      "sh",
      "${path.module}/get_kubeconfig.sh"
  ]

  depends_on = [
    local_file.script_kubeconfig
  ]
}

