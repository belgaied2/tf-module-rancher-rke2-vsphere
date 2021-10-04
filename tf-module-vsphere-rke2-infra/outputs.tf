output "nodes" {
  value = [
    for vm in vsphere_virtual_machine.vm: vm.default_ip_address
  ]
  
}