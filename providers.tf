terraform {
  required_providers {
    rancher2 = {
      source = "rancher/rancher2"
      version = "1.20.0"
    }

    # vsphere = {
    #   source = "hashicorp/vsphere"
    #   version = "2.0.2"
    # }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.13.0"
    }
  }
}

provider "rancher2" {
  # Configuration options
  api_url = "https://${var.rancher_hostname}"
  bootstrap = true
  alias = "bootstrap"
  insecure = true
}

provider "vsphere" {
  user           = var.vcenter_username
  password       = var.vcenter_password
  vsphere_server = var.vcenter_host

  # If you have a self-signed cert
  allow_unverified_ssl = true

}


resource "null_resource" "rancher_availability_check" {
  depends_on = [
    module.rke2-upstream-provision
  ]

  provisioner "local-exec" {
    command = "while ! [[ $(curl -I -L -k https://${var.rancher_hostname} 2>/dev/null | head -n 1 | cut -d$' ' -f2) -eq 200 ]] ; do sleep 30; echo 'Waiting for another 30s'; done"
    
  }
}

#resource "time_sleep" "rancher_availability_check" {
#
#  depends_on = [
#    module.vsphere-infra-rancher
#  ]
#  provisioner "remote-exec" {
#    inline = [
#      " sleep 30"
#    ]
#    connection {
#      type     = "ssh"
#      user     = var.ssh_user
#      password = var.ssh_password
#      host     = module.vsphere-infra-rancher.nodes[0]
#    }
#  }
#}

resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap
  password = var.rancher_bootstrap_password
  depends_on = [null_resource.rancher_availability_check]
}

provider "rancher2" {
  # Configuration options
  api_url = "https://${var.rancher_hostname}"
  alias = "rancher"
  token_key = rancher2_bootstrap.admin.token
  insecure = true

}

# provider "kubernetes" {

#   experiments {
#     manifest_resource = true
#   }

#   host                = module.rke2-downstream-provision.kubeconfig.clusters[0].cluster.server
#   client_certificate  = base64decode(module.rke2-downstream-provision.kubeconfig.users[0].user.client-certificate-data)
#   client_key          = base64decode(module.rke2-downstream-provision.kubeconfig.users[0].user.client-key-data)
#   cluster_ca_certificate = base64decode(module.rke2-downstream-provision.kubeconfig.clusters[0].cluster.certificate-authority-data)
# }

# provider "http-full" {
  
# }

# provider "kubectl" {
#   alias = "downstream"

#   host                = module.rke2-downstream-provision.kubeconfig.clusters[0].cluster.server
#   client_certificate  = base64decode(module.rke2-downstream-provision.kubeconfig.users[0].user.client-certificate-data)
#   client_key          = base64decode(module.rke2-downstream-provision.kubeconfig.users[0].user.client-key-data)
#   cluster_ca_certificate = base64decode(module.rke2-downstream-provision.kubeconfig.clusters[0].cluster.certificate-authority-data)
#   load_config_file = false
# }