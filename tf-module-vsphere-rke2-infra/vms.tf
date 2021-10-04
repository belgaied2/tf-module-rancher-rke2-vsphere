data "vsphere_datacenter" "dc" {
  name = var.vsphere_dc
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_ds
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_rp
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_net
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "template_file" "config_server_yaml" {
  template = "${file("${path.module}/file_templates/config_server.yaml.tpl")}"
  vars = {
    rke2_token = var.rke2_token
  }
}

data "template_file" "config_servers_other_yaml" {
  template = "${file("${path.module}/file_templates/config_servers_other.yaml.tpl")}"
  vars = {
    rke2_token = var.rke2_token
    server = vsphere_virtual_machine.vm[0].default_ip_address
  }
}


data "template_file" "rancher_manifest" {
  template = "${file("${path.module}/file_templates/rancher_manifest.yaml.tpl")}"
  vars = {
    rancher_hostname = var.rancher_hostname
  }
}


resource "vsphere_virtual_machine" "vm" {
  count = var.vm_count
  name             = "${var.vm_name_prefix}-${count.index}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_cpus
  memory   = var.vm_mem
  guest_id = var.vsphere_guest_id
  firmware = "efi"


  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = var.vm_disk_size
    thin_provisioned = false
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    
  }

  
}

resource null_resource "rke2_server1_provisioning" {


  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = vsphere_virtual_machine.vm[0].default_ip_address
    }
    inline = [
      "mkdir $HOME/.ssh",
      "cat > $HOME/.ssh/authorized_keys <<EOF\n${file(var.public_key_path)}\nEOF",
      "systemctl stop firewalld && systemctl disable firewalld",
      "mkdir -p /etc/rancher/rke2", 
      "mkdir -p /var/lib/rancher/rke2/server/manifests",
      "mkdir -p /var/lib/rancher/rke2/agent/images",
      "mkdir -p /opt/rke2"
    ]
  }

  # ## Copy system images to target folder
  # provisioner "file" {
  #   source = "${path.module}/images"
  #   destination = "/var/lib/rancher/rke2/agent"

  #   connection {
  #     type     = "ssh"
  #     user     = var.ssh_user
  #     password = var.ssh_password
  #     host     = vsphere_virtual_machine.vm[count.index].default_ip_address
  #   }
  # }

  ## copy install script and RKE2 binary to /opt/rke2
  provisioner "file" {
    source = "${path.module}/rke2"
    destination = "/opt/"

    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = vsphere_virtual_machine.vm[0].default_ip_address
    }
  }

  provisioner "file" {
    content = data.template_file.config_server_yaml.rendered
    destination = "/etc/rancher/rke2/config.yaml"

    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = vsphere_virtual_machine.vm[0].default_ip_address
    }
  }

  provisioner "file" {
    content = data.template_file.rancher_manifest.rendered
    destination = "/var/lib/rancher/rke2/server/manifests/rancher-helm-chart.yaml"

    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = vsphere_virtual_machine.vm[0].default_ip_address
    }
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = vsphere_virtual_machine.vm[0].default_ip_address
    }
    inline = [
      "chmod +x /opt/rke2/install.sh",
      "INSTALL_RKE2_METHOD=tar INSTALL_RKE2_ARTIFACT_PATH=/opt/rke2 /opt/rke2/install.sh",
      "systemctl enable rke2-server && systemctl start rke2-server",

    ]
  }

}

resource null_resource "rke2_servers_others_provisioning" {

count = var.vm_count - 1 

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = vsphere_virtual_machine.vm[count.index + 1].default_ip_address
    }
    inline = [
      "mkdir $HOME/.ssh",
      "cat > $HOME/.ssh/authorized_keys <<EOF\n${file(var.public_key_path)}\nEOF",
      "systemctl stop firewalld && systemctl disable firewalld",
      "mkdir -p /etc/rancher/rke2", 
      "mkdir -p /var/lib/rancher/rke2/server/manifests",
      "mkdir -p /var/lib/rancher/rke2/agent/images",
      "mkdir -p /opt/rke2"
    ]
  }

  # ## Copy system images to target folder
  # provisioner "file" {
  #   source = "${path.module}/images"
  #   destination = "/var/lib/rancher/rke2/agent"

  #   connection {
  #     type     = "ssh"
  #     user     = var.ssh_user
  #     password = var.ssh_password
  #     host     = vsphere_virtual_machine.vm[count.index].default_ip_address
  #   }
  # }

  ## copy install script and RKE2 binary to /opt/rke2
  provisioner "file" {
    source = "${path.module}/rke2"
    destination = "/opt/"

    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = vsphere_virtual_machine.vm[count.index + 1].default_ip_address
    }
  }

  provisioner "file" {
    content = data.template_file.config_servers_other_yaml.rendered
    destination = "/etc/rancher/rke2/config.yaml"

    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = vsphere_virtual_machine.vm[count.index+1].default_ip_address
    }
  }

  provisioner "file" {
    content = data.template_file.rancher_manifest.rendered
    destination = "/var/lib/rancher/rke2/server/manifests/rancher-helm-chart.yaml"

    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = vsphere_virtual_machine.vm[count.index+1].default_ip_address
    }
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = var.ssh_user
      password = var.ssh_password
      host     = vsphere_virtual_machine.vm[count.index+1].default_ip_address
    }
    inline = [
      "chmod +x /opt/rke2/install.sh",
      "INSTALL_RKE2_METHOD=tar INSTALL_RKE2_ARTIFACT_PATH=/opt/rke2 /opt/rke2/install.sh",
      "systemctl enable rke2-server && systemctl start rke2-server",

    ]
  }

  # provisioner "remote-exec" {
  #   when = destroy
  #   connection {
  #     type     = "ssh"
  #     # user     = var.ssh_user
  #     # password = var.ssh_password
  #     # host     = vsphere_virtual_machine.vm[0].default_ip_address
  #   }
  #   inline = [
  #     "rke2-uninstall.sh",

  #   ]
    
  # }
}
