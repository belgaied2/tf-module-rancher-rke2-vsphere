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


# resource "null_resource" "rancher_availability_check" {

#   provisioner "remote-exec" {
#     inline = [
#       "while ! [[ $(curl -I -L -kv ${var.rancher_hostname} 2>/dev/null | head -n 1 | cut -d$' ' -f2) -eq 200 ]] ; do sleep 60; echo 'Waiting for another 60s'; done"
#     ]
#     connection {
#       type     = "ssh"
#       user     = var.ssh_user
#       password = var.ssh_password
#       host     = module.vsphere-infra-rancher.nodes[0]
#     }
#   }
  
# }

resource "null_resource" "rancher_availability_check" {

  provisioner "remote-exec" {
    inline = [
      " sleep 1000"
    ]
    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = module.vsphere-infra-rancher.nodes[0]
    }
  }
}

resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap
  password = var.rancher_bootstrap_password
  # current_password = "A$$0uma1"
  depends_on = [null_resource.rancher_availability_check]
}

provider "rancher2" {
  # Configuration options
  api_url = "https://${var.rancher_hostname}"
  alias = "rancher"
  token_key = rancher2_bootstrap.admin.token
  insecure = true

}
