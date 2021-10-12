## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.13.0 |
| <a name="requirement_rancher2"></a> [rancher2](#requirement\_rancher2) | 1.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_rancher2"></a> [rancher2](#provider\_rancher2) | 1.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.kubectl_apply](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [rancher2_cluster.rke2_imported](https://registry.terraform.io/providers/rancher/rancher2/1.20.0/docs/resources/cluster) | resource |
| [http_http.get_import_manifest](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_cluster_description"></a> [app\_cluster\_description](#input\_app\_cluster\_description) | Description of the Downstream Cluster to be created | `string` | n/a | yes |
| <a name="input_app_cluster_name"></a> [app\_cluster\_name](#input\_app\_cluster\_name) | Name of the Downstream Cluster to be created | `string` | n/a | yes |
| <a name="input_kubeconfig"></a> [kubeconfig](#input\_kubeconfig) | kubeconfig file of the downstream cluster | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_import_manifest"></a> [import\_manifest](#output\_import\_manifest) | n/a |
