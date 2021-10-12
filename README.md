# Terraform Module for RKE2 and Rancher v2.6.0 on vSphere

This repository aims at providing a reference configuration / module to use in order to:
- Create a set of VMs on vSphere using CentOS 8.4 
- Deploy 2 RKE2 Clusters, one with 3 nodes for Rancher and one with a variable amount of nodes as a downstream (application) cluster
- Have Rancher automatically installed with a given certificate on the 3-node cluster
- Have the other cluster automatically be imported into the Rancher installation.

# Principle
The principle to achieve the above uses Terraform Modules:
- A module for the infrastructure (creating VMs in vSphere)
- A module for the installation of RKE2 (with or without Rancher)
- A module for installing Apps through the Rancher Market Place.
- A module for importing a cluster into Rancher 

Naturally, it is possible to modify the configuration to adapt it to you own needs. Example: if you don't need the provisioning of VMs in vSphere, you can use remove the call to that module in the `main.tf` and modify the other module calls (`rke2-upstream-provision` and `rke2-downstream-provision`) to use some other source for the IP addresses.

# Usage

## Pre-requisites

### Variables
A number of values necessary to the deployment of a Rancher platform were parametrized, making the module quite flexible. Some variables do not have a default value, it is necessary to provide these values for the configuration to apply. You can run `terraform apply` and answer the prompts with the necessary values, but this would be cumbursome. A better solution is to make use of a `tfvars` kind of file, which is a simple file with key,value pairs providing Terraform with all the necessary input it needs.

An sample `terraform.tfvars` is provided in the configuration, you can adapt it for your own environment.

### RKE2 Binaries
The module `tf-module-rke2-provision` deploys RKE2 in an Air Gapped environment using the procedure described [here](https://docs.rke2.io/install/airgap/#tarball-method) using the tarvall method. This procedure needs pre-downloaded tarball distribution of RKE2 including the RKE2 binary, all the system container images as well as a SHA256 checksum file, all of which can be found on the [Github Releases page for RKE2](https://github.com/rancher/rke2/releases/). These files should be copied into the folder `tf-module-rke2-provision/rke2`. Please also make sure to have a `install.sh` file in the same folder, coming from the current [RKE2 installation script](https://get.rke2.io/).

# Module description
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.13.0 |
| <a name="requirement_rancher2"></a> [rancher2](#requirement\_rancher2) | 1.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |
| <a name="provider_rancher2.bootstrap"></a> [rancher2.bootstrap](#provider\_rancher2.bootstrap) | 1.20.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rke2-downstream-import-cluster"></a> [rke2-downstream-import-cluster](#module\_rke2-downstream-import-cluster) | ./tf-module-downstream-deploy | n/a |
| <a name="module_rke2-downstream-provision"></a> [rke2-downstream-provision](#module\_rke2-downstream-provision) | ./tf-module-rke2-provision | n/a |
| <a name="module_rke2-upstream-provision"></a> [rke2-upstream-provision](#module\_rke2-upstream-provision) | ./tf-module-rke2-provision | n/a |
| <a name="module_vsphere-infra-downstream"></a> [vsphere-infra-downstream](#module\_vsphere-infra-downstream) | ./tf-module-vsphere-infra | n/a |
| <a name="module_vsphere-infra-rancher"></a> [vsphere-infra-rancher](#module\_vsphere-infra-rancher) | ./tf-module-vsphere-infra | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.rancher_availability_check](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [rancher2_bootstrap.admin](https://registry.terraform.io/providers/rancher/rancher2/1.20.0/docs/resources/bootstrap) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_cluster_description"></a> [app\_cluster\_description](#input\_app\_cluster\_description) | Description of the Downstream Cluster to be created | `string` | n/a | yes |
| <a name="input_app_cluster_name"></a> [app\_cluster\_name](#input\_app\_cluster\_name) | Name of the Downstream Cluster to be created | `string` | n/a | yes |
| <a name="input_downstream_cp_vm_count"></a> [downstream\_cp\_vm\_count](#input\_downstream\_cp\_vm\_count) | Number of Control Plane VMs for the downstream Cluster | `number` | n/a | yes |
| <a name="input_downstream_vm_name_prefix"></a> [downstream\_vm\_name\_prefix](#input\_downstream\_vm\_name\_prefix) | Name prefix for the Downstream VMs | `string` | n/a | yes |
| <a name="input_downstream_wk_vm_count"></a> [downstream\_wk\_vm\_count](#input\_downstream\_wk\_vm\_count) | Number of Worker VMs for the downstream Cluster | `number` | n/a | yes |
| <a name="input_public_key_path"></a> [public\_key\_path](#input\_public\_key\_path) | path of public key to push to the VMs | `any` | n/a | yes |
| <a name="input_rancher_bootstrap_password"></a> [rancher\_bootstrap\_password](#input\_rancher\_bootstrap\_password) | Desired password for Rancher | `string` | n/a | yes |
| <a name="input_rancher_hostname"></a> [rancher\_hostname](#input\_rancher\_hostname) | Desired hostname for the Rancher App | `any` | n/a | yes |
| <a name="input_rancher_vm_count"></a> [rancher\_vm\_count](#input\_rancher\_vm\_count) | Number of VMs to spin up for RKE | `number` | `3` | no |
| <a name="input_rancher_vm_name_prefix"></a> [rancher\_vm\_name\_prefix](#input\_rancher\_vm\_name\_prefix) | Prefix for the VM name in vSphere | `string` | `"rancher-ha"` | no |
| <a name="input_rke2_token"></a> [rke2\_token](#input\_rke2\_token) | Desired RKE2 token | `any` | n/a | yes |
| <a name="input_ssh_password"></a> [ssh\_password](#input\_ssh\_password) | SSH Password to connect to VM with | `any` | n/a | yes |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | SSH Username to connect to VM with | `any` | n/a | yes |
| <a name="input_vcenter_host"></a> [vcenter\_host](#input\_vcenter\_host) | n/a | `string` | `""` | no |
| <a name="input_vcenter_password"></a> [vcenter\_password](#input\_vcenter\_password) | n/a | `string` | `""` | no |
| <a name="input_vcenter_username"></a> [vcenter\_username](#input\_vcenter\_username) | n/a | `string` | `""` | no |
| <a name="input_vm_cpus"></a> [vm\_cpus](#input\_vm\_cpus) | Number of CPUs to give to VM | `number` | `2` | no |
| <a name="input_vm_disk_size"></a> [vm\_disk\_size](#input\_vm\_disk\_size) | Size in GB of the main VM's Disk | `number` | `20` | no |
| <a name="input_vm_mem"></a> [vm\_mem](#input\_vm\_mem) | Memory size in MB for VM | `number` | `8192` | no |
| <a name="input_vm_template"></a> [vm\_template](#input\_vm\_template) | n/a | `string` | `""` | no |
| <a name="input_vsphere_dc"></a> [vsphere\_dc](#input\_vsphere\_dc) | vSphere Datacenter to use to create VMs | `any` | n/a | yes |
| <a name="input_vsphere_ds"></a> [vsphere\_ds](#input\_vsphere\_ds) | vSphere Datastore to use to create VMs | `any` | n/a | yes |
| <a name="input_vsphere_guest_id"></a> [vsphere\_guest\_id](#input\_vsphere\_guest\_id) | Type of OS for Guest | `string` | `"rhel7_64Guest"` | no |
| <a name="input_vsphere_net"></a> [vsphere\_net](#input\_vsphere\_net) | vSphere Network to attribute the VMs to | `any` | n/a | yes |
| <a name="input_vsphere_rp"></a> [vsphere\_rp](#input\_vsphere\_rp) | vSphere Resource Pool to attribute the VMs to | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_downstream_import_manifest"></a> [downstream\_import\_manifest](#output\_downstream\_import\_manifest) | n/a |
| <a name="output_downstream_kubeconfig"></a> [downstream\_kubeconfig](#output\_downstream\_kubeconfig) | n/a |
| <a name="output_upstream_kubeconfig"></a> [upstream\_kubeconfig](#output\_upstream\_kubeconfig) | n/a |
