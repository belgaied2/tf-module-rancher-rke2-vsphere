## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_rancher2"></a> [rancher2](#requirement\_rancher2) | 1.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_rancher2.rancher"></a> [rancher2.rancher](#provider\_rancher2.rancher) | 1.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [rancher2_app_v2.rancher_monitor](https://registry.terraform.io/providers/rancher/rancher2/1.20.0/docs/resources/app_v2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apps"></a> [apps](#input\_apps) | List of apps to install | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_rancher_token"></a> [rancher\_token](#input\_rancher\_token) | Token for the Rancher API | `string` | n/a | yes |
| <a name="input_rancher_url"></a> [rancher\_url](#input\_rancher\_url) | URL to access Rancher App | `string` | n/a | yes |

## Outputs

No outputs.
