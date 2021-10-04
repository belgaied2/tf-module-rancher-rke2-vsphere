module "vsphere-infra-rancher" {
  source = "./tf-module-vsphere-rke2-infra"

  vcenter_host     = var.vcenter_host
  vcenter_username = var.vcenter_username
  vcenter_password = var.vcenter_password
  vm_template      = var.vm_template
  vm_count         = var.vm_count
  vsphere_dc       = var.vsphere_dc
  vsphere_ds       = var.vsphere_ds
  vsphere_rp       = var.vsphere_rp
  vsphere_net      = var.vsphere_net
  vm_cpus          = var.vm_cpus
  vm_mem           = var.vm_mem
  vm_disk_size     = var.vm_disk_size
  vsphere_guest_id = var.vsphere_guest_id
  vm_name_prefix   = var.rancher_vm_name_prefix
  ssh_user         = var.ssh_user
  ssh_password     = var.ssh_password
  public_key_path  = var.public_key_path
  rke2_token       = var.rke2_token
  rancher_hostname = var.rancher_hostname

}

module "vsphere-rancher-apps" {
  source = "./tf-module-rancher2-apps"
  rancher_url = var.rancher_hostname
  rancher_token = rancher2_bootstrap.admin.token
  apps = ["rancher-monitoring"]
}