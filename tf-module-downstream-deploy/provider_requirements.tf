terraform {
  required_providers {
    rancher2 = {
      source = "rancher/rancher2"
      version = "1.20.0"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.13.0"
    }

    # http-full = {
    #   source = "salrashid123/http-full"
    #   version = "1.1.1"
    # }
  }
}

