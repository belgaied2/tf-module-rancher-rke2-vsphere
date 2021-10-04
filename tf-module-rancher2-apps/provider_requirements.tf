terraform {
  required_providers {
    rancher2 = {
      source = "rancher/rancher2"
      version = "1.20.0"
    }
  }
}

provider "rancher2" {
  # Configuration options
  api_url = "https://${var.rancher_url}"
  alias = "rancher"
  token_key = var.rancher_token
}