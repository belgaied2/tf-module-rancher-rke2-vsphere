terraform {
  backend "remote" {
    organization = "belgaied"

    workspaces {
      name = "tf-module-rancher-vsphere"
    }
  }
}