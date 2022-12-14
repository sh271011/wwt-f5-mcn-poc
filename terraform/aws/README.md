## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |
| <a name="requirement_volterra"></a> [volterra](#requirement\_volterra) | 0.11.9 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws-iam"></a> [aws-iam](#module\_aws-iam) | ./modules/aws-iam | n/a |
| <a name="module_volterra-namespace"></a> [volterra-namespace](#module\_volterra-namespace) | ./modules/volterra-namespace | n/a |
| <a name="module_volterra-vpc"></a> [volterra-vpc](#module\_volterra-vpc) | ./modules/volterra-vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_p12_file"></a> [api\_p12\_file](#input\_api\_p12\_file) | API credentials file | `string` | `"./<your-api-creds-file>.p12"` | no |
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | Tenant API for Volterra console | `string` | `"https://<your tenant url>/api"` | no |
| <a name="input_aws_disk_size"></a> [aws\_disk\_size](#input\_aws\_disk\_size) | Disk size in GiB (80 default) | `number` | `80` | no |
| <a name="input_aws_hw_type"></a> [aws\_hw\_type](#input\_aws\_hw\_type) | Name of the AWS certified HW type (Enter for default) | `string` | `"aws-byol-voltmesh"` | no |
| <a name="input_aws_instance_type"></a> [aws\_instance\_type](#input\_aws\_instance\_type) | AWS instance type used for the Volterra site (Enter for default) | `string` | `"t3.2xlarge"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region where Site will be created | `string` | n/a | yes |
| <a name="input_local_subnet"></a> [local\_subnet](#input\_local\_subnet) | Local subnet in CIDR notation | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for new namespace, or queried existing namespace. | `string` | n/a | yes |
| <a name="input_policyname"></a> [policyname](#input\_policyname) | Name for AWS policy | `string` | n/a | yes |
| <a name="input_primary_ipv4"></a> [primary\_ipv4](#input\_primary\_ipv4) | Primary VPC address space | `string` | n/a | yes |
| <a name="input_rolename"></a> [rolename](#input\_rolename) | Name for AWS role | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Name for new AWS service account. | `string` | n/a | yes |
| <a name="input_vpc_site_name"></a> [vpc\_site\_name](#input\_vpc\_site\_name) | Name for VPC site | `string` | n/a | yes |

## Outputs

No outputs.
