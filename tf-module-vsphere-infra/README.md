## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vsphere"></a> [vsphere](#requirement\_vsphere) | 2.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | 2.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vsphere_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/vsphere/2.0.2/docs/resources/virtual_machine) | resource |
| [vsphere_datacenter.dc](https://registry.terraform.io/providers/hashicorp/vsphere/2.0.2/docs/data-sources/datacenter) | data source |
| [vsphere_datastore.datastore](https://registry.terraform.io/providers/hashicorp/vsphere/2.0.2/docs/data-sources/datastore) | data source |
| [vsphere_network.network](https://registry.terraform.io/providers/hashicorp/vsphere/2.0.2/docs/data-sources/network) | data source |
| [vsphere_resource_pool.pool](https://registry.terraform.io/providers/hashicorp/vsphere/2.0.2/docs/data-sources/resource_pool) | data source |
| [vsphere_virtual_machine.template](https://registry.terraform.io/providers/hashicorp/vsphere/2.0.2/docs/data-sources/virtual_machine) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vcenter_host"></a> [vcenter\_host](#input\_vcenter\_host) | n/a | `string` | `""` | no |
| <a name="input_vcenter_password"></a> [vcenter\_password](#input\_vcenter\_password) | n/a | `string` | `""` | no |
| <a name="input_vcenter_username"></a> [vcenter\_username](#input\_vcenter\_username) | n/a | `string` | `""` | no |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | Number of VMs to spin up for RKE | `number` | `3` | no |
| <a name="input_vm_cpus"></a> [vm\_cpus](#input\_vm\_cpus) | Number of CPUs to give to VM | `number` | `2` | no |
| <a name="input_vm_disk_size"></a> [vm\_disk\_size](#input\_vm\_disk\_size) | Size in GB of the main VM's Disk | `number` | `40` | no |
| <a name="input_vm_mem"></a> [vm\_mem](#input\_vm\_mem) | Memory size in MB for VM | `number` | `8192` | no |
| <a name="input_vm_name_prefix"></a> [vm\_name\_prefix](#input\_vm\_name\_prefix) | Prefix for the VM name in vSphere | `string` | `"rancher-ha"` | no |
| <a name="input_vm_template"></a> [vm\_template](#input\_vm\_template) | n/a | `string` | `""` | no |
| <a name="input_vsphere_dc"></a> [vsphere\_dc](#input\_vsphere\_dc) | vSphere Datacenter to use to create VMs | `any` | n/a | yes |
| <a name="input_vsphere_ds"></a> [vsphere\_ds](#input\_vsphere\_ds) | vSphere Datastore to use to create VMs | `any` | n/a | yes |
| <a name="input_vsphere_guest_id"></a> [vsphere\_guest\_id](#input\_vsphere\_guest\_id) | Type of OS for Guest | `string` | `"rhel8_64Guest"` | no |
| <a name="input_vsphere_net"></a> [vsphere\_net](#input\_vsphere\_net) | vSphere Network to attribute the VMs to | `any` | n/a | yes |
| <a name="input_vsphere_rp"></a> [vsphere\_rp](#input\_vsphere\_rp) | vSphere Resource Pool to attribute the VMs to | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nodes"></a> [nodes](#output\_nodes) | n/a |
