variable "vcenter_host" {
  default = ""
}


variable "vcenter_username" {
  default = ""
}


variable "vcenter_password" {
  default = ""
}

variable "vm_template" {
  default = ""
}

# variable "rancher_version" {
#   description = "Version of Rancher Server"
#   default     = "2.4.8"
# }


variable "rancher_vm_count" {
  description = "Number of VMs to spin up for RKE"
  default     = 3
}

variable "vsphere_dc" {
  description = "vSphere Datacenter to use to create VMs"
}

variable "vsphere_ds" {
  description = "vSphere Datastore to use to create VMs"
}

variable "vsphere_rp" {
  description = "vSphere Resource Pool to attribute the VMs to"
}

variable "vsphere_net" {
  description = "vSphere Network to attribute the VMs to"
}

variable "vm_cpus" {
  description = "Number of CPUs to give to VM"
  default     = 2
}

variable "vm_mem" {
  description = "Memory size in MB for VM"
  default     = 8192
}

variable "vm_disk_size" {
  description = "Size in GB of the main VM's Disk"
  default     = 20
}

variable "vsphere_guest_id" {
  description = "Type of OS for Guest"
  default     = "rhel7_64Guest"
}

variable "rancher_vm_name_prefix" {
  description = "Prefix for the VM name in vSphere"
  default     = "rancher-ha"
}

# Connectivity to final VMs
variable "ssh_user" {
  description = "SSH Username to connect to VM with"
}


variable "ssh_password" {
  description = "SSH Password to connect to VM with"
}

variable "public_key_path" {
  description = "path of public key to push to the VMs"
}

variable "rancher_hostname" {
  description = "Desired hostname for the Rancher App"
}

variable "rke2_token" {
  description = "Desired RKE2 token"  
}


variable "rancher_bootstrap_password" {
  type = string
  description = "Desired password for Rancher"
}

variable "downstream_cp_vm_count" {
  type = number
  description = "Number of Control Plane VMs for the downstream Cluster"

}

variable "downstream_wk_vm_count" {
  type = number
  description = "Number of Worker VMs for the downstream Cluster"
}

variable "downstream_vm_name_prefix" {
  type = string
  description = "Name prefix for the Downstream VMs"
}

variable "app_cluster_name" {
  type = string
  description = "Name of the Downstream Cluster to be created"
  
}

variable "app_cluster_description" {
  type = string
  description = "Description of the Downstream Cluster to be created"
}