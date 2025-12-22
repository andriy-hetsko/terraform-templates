<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_settings"></a> [ami\_settings](#input\_ami\_settings) | n/a | <pre>object({<br>    ami_type       = string<br>    ami_os_version = string<br>    ami_codename   = string<br>    ami_arch       = string<br>    owners         = list(string)<br>    filters        = list(any)<br>  })</pre> | n/a | yes |
| <a name="input_associate_public_ip"></a> [associate\_public\_ip](#input\_associate\_public\_ip) | n/a | `bool` | `false` | no |
| <a name="input_data_volume"></a> [data\_volume](#input\_data\_volume) | n/a | <pre>object({<br>    enabled    = bool<br>    device     = optional(string)<br>    size       = optional(number)<br>    type       = optional(string)<br>    iops       = optional(number)<br>    throughput = optional(number)<br>  })</pre> | <pre>{<br>  "enabled": false<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | n/a | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `any` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `any` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | Logical role of EC2 instance (postgres17, app etc) | `string` | n/a | yes |
| <a name="input_root_volume"></a> [root\_volume](#input\_root\_volume) | n/a | <pre>object({<br>    size       = number<br>    type       = string<br>    iops       = optional(number)<br>    throughput = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_id"></a> [ami\_id](#output\_ami\_id) | n/a |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |
<!-- END_TF_DOCS -->