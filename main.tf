module "vsphere-infra-rancher" {
  source = "./tf-module-vsphere-infra"

  vcenter_host     = var.vcenter_host
  vcenter_username = var.vcenter_username
  vcenter_password = var.vcenter_password
  vm_template      = var.vm_template
  vm_count         = var.rancher_vm_count
  vsphere_dc       = var.vsphere_dc
  vsphere_ds       = var.vsphere_ds
  vsphere_rp       = var.vsphere_rp
  vsphere_net      = var.vsphere_net
  vm_cpus          = var.vm_cpus
  vm_mem           = var.vm_mem
  vm_disk_size     = var.vm_disk_size
  vsphere_guest_id = var.vsphere_guest_id
  vm_name_prefix   = var.rancher_vm_name_prefix


}

module "rke2-upstream-provision" {
  source = "./tf-module-rke2-provision"

  cp_vm_count      = var.rancher_vm_count
  wk_vm_count      = 0
  vm_name_prefix   = var.rancher_vm_name_prefix
  ssh_user         = var.ssh_user
  ssh_password     = var.ssh_password
  public_key_path  = var.public_key_path
  rke2_token       = var.rke2_token
  rancher_hostname = var.rancher_hostname
  vm_ips           = module.vsphere-infra-rancher.nodes
  do_deploy_rancher = true
}


# module "vsphere-rancher-apps" {
#   source = "./tf-module-rancher2-apps"
#   rancher_url = var.rancher_hostname
#   rancher_token = rancher2_bootstrap.admin.token
#   apps = ["rancher-monitoring"]
# }

module "vsphere-infra-downstream" {
  source = "./tf-module-vsphere-infra"

  vcenter_host     = var.vcenter_host
  vcenter_username = var.vcenter_username
  vcenter_password = var.vcenter_password
  vm_template      = var.vm_template
  vm_count         = var.downstream_cp_vm_count + var.downstream_wk_vm_count
  vsphere_dc       = var.vsphere_dc
  vsphere_ds       = var.vsphere_ds
  vsphere_rp       = var.vsphere_rp
  vsphere_net      = var.vsphere_net
  vm_cpus          = var.vm_cpus
  vm_mem           = var.vm_mem
  vm_disk_size     = var.vm_disk_size
  vsphere_guest_id = var.vsphere_guest_id
  vm_name_prefix   = var.downstream_vm_name_prefix
}

module "rke2-downstream-provision" {
  source = "./tf-module-rke2-provision"

  cp_vm_count      = var.downstream_cp_vm_count
  wk_vm_count      = var.downstream_wk_vm_count 
  vm_name_prefix   = var.downstream_vm_name_prefix
  ssh_user         = var.ssh_user
  ssh_password     = var.ssh_password
  public_key_path  = var.public_key_path
  rke2_token       = var.rke2_token
  vm_ips           = module.vsphere-infra-downstream.nodes
  do_deploy_rancher = false
}

module "rke2-downstream-import-cluster" {
  source = "./tf-module-downstream-deploy"
  providers = {
    rancher2 = rancher2.rancher,
    # kubectl = kubectl.downstream
    # http     = http-full
   }
  kubeconfig = module.rke2-downstream-provision.kubeconfig
  app_cluster_name = var.app_cluster_name
  app_cluster_description = var.app_cluster_description


  # depends_on = [
  #   module.rke2-downstream-provision
  # ]
}


