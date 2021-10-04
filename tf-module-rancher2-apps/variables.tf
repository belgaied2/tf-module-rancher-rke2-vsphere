variable "apps" {
  type = list(string)
  description = "List of apps to install"
  default = [""]
}

variable "rancher_url" {
  type = string
  description = "URL to access Rancher App"
}

variable "rancher_token" {
  type = string
  description = "Token for the Rancher API"
}
