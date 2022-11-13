## ARJ-Stack: Serverless Amazon Managed Streaming for Apache Kafka (MSK) Terraform module

A Terraform module for configuring Serverless Amazon Managed Streaming for Apache Kafka

### Resources

This module features the following components to be provisioned with different combinations:

- Amazon MSK Cluster [[aws_msk_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster)]
- Security Group [[aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)]
    - Security Group to be attached with MSK
- Security Group Rules [[aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)]


### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.22.0 |

### Examples

Refer [Configuration Examples](https://github.com/arjstack/terraform-aws-examples/tree/main/aws-msk-serverless) for effectively utilizing this module.

### Inputs

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="cluster_name"></a> [cluster_name](#input\_cluster\_name) | The name of the serverless cluster. | `string` |  | yes |
| <a name="vpc_id"></a> [vpc_id](#input\_vpc\_id) | The ID of VPC that is used to create Security Group.  Required only where `create_sg` is set `true` | `string` | `null` | no |
| <a name="subnets"></a> [subnets](#input\_subnets) | A list of subnets in at least two different Availability Zones that host the client applications. | `list(string)` |  | yes |
| <a name="create_sg"></a> [create_sg](#input\_create\_sg) | Flag to decide to create Security Group for MSK. | `bool` | `false` | no |
| <a name="sg_name"></a> [sg_name](#input\_sg\_name) | The name of the Security group. | `string` | `null` | no |
| <a name="sg_rules"></a> [sg_rules](#input\_sg\_rules) | Configuration Map for Security Group Rules | `map` | `{}` | no |
| <a name="allowed_sg"></a> [allowed_sg](#input\_allowed\_sg) | List of Source Security Group IDs defined in Ingress of the created SG. | `list(string)` | `[]` | no |
| <a name="additional_sg"></a> [additional_sg](#input\_additional\_sg) | List of Existing Security Group IDs associated with MSK. | `list(string)` | `[]` | no |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to MSK. | `map(string)` | `{}` | no |

### Outputs

| Name | Type | Description |
|:------|:------|:------|
| <a name="arn"></a> [arn](#output\_arn) | `string` | The ARN of the serverless MSK cluster. |

### Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-msk-serverless/graphs/contributors).

