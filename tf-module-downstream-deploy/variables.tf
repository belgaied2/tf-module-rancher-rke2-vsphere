variable "app_cluster_name" {
  type = string
  description = "Name of the Downstream Cluster to be created"
  
}

variable "app_cluster_description" {
  type = string
  description = "Description of the Downstream Cluster to be created"
}

variable "kubeconfig" {
  # type = object
  description = "kubeconfig file of the downstream cluster"
}



