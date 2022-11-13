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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.27.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.27.0 |

### Examples

Refer [Configuration Examples](https://github.com/arjstack/terraform-aws-examples/tree/main/aws-msk-serverless) for effectively utilizing this module.

### Inputs

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="cluster_name"></a> [cluster_name](#input\_cluster\_name) | The name of the serverless cluster. | `string` |  | yes |  |
| <a name="vpc_id"></a> [vpc_id](#input\_vpc\_id) | The ID of VPC that is used to create Security Group.  Required only where `create_sg` is set `true` | `string` | `null` | no |  |
| <a name="subnets"></a> [subnets](#input\_subnets) | A list of subnets in at least two different Availability Zones that host the client applications. | `list(string)` |  | yes |  |
| <a name="create_sg"></a> [create_sg](#input\_create\_sg) | Flag to decide to create Security Group for MSK. | `bool` | `false` | no |  |
| <a name="sg_name"></a> [sg_name](#input\_sg\_name) | The name of the Security group. | `string` | `null` | no |  |
| <a name="sg_rules"></a> [sg_rules](#sg\_rules) | Configuration Map for Security Group Rules | `map` | `{}` | no | <pre>{<br>   ingress = [<br>      {<br>        rule_name = "Self Ingress Rule"<br>        description = "Self Ingress Rule"<br>        from_port =0<br>        to_port = 0<br>        protocol = "-1"<br>        self = true<br>      },<br>      {<br>        rule_name = "Ingress from IPv4 CIDR"<br>        description = "IPv4 Rule"<br>        from_port = 443<br>        to_port = 443<br>        protocol = "tcp"<br>        cidr_blocks = ["xx.xx.xx.xx/xx"]<br>      }<br>   ]<br>   egress =[<br>      {<br>        rule_name = "Self Egress Rule"<br>        description = "Self Egress Rule"<br>        from_port =0<br>        to_port = 0<br>        protocol = "-1"<br>        self = true<br>      }<br>   ]<br>} |
| <a name="additional_sg"></a> [additional_sg](#input\_additional\_sg) | List of Existing Security Group IDs associated with MSK. | `list(string)` | `[]` | no |  |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to MSK. | `map(string)` | `{}` | no |  |

### Nested Configuration Maps:

#### sg_rules [ Ingress / Egress ]

- `cidr_blocks` Cannot be specified with `source_security_group_id` or `self`.
- `ipv6_cidr_blocks` Cannot be specified with `source_security_group_id` or `self`.
- `source_security_group_id` Cannot be specified with `cidr_blocks`, `ipv6_cidr_blocks` or `self`.
- `self` Cannot be specified with `cidr_blocks`, `ipv6_cidr_blocks` or `source_security_group_id`.

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="rule_name"></a> [rule_name](#input\_rule\_name) | The name of the Rule (Used for terraform perspective to maintain unicity) | `string` |  | yes |
| <a name="description"></a> [description](#input\_description) | Description of the rule. | `string` |  | yes |
| <a name="from_port"></a> [from_port](#input\_from\_port) | Start port (or ICMP type number if protocol is "icmp" or "icmpv6"). | `number` |  | yes |
| <a name="to_port"></a> [to_port](#input\_to\_port) | End port (or ICMP code if protocol is "icmp"). | `number` |  | yes |
| <a name="protocol"></a> [protocol](#input\_protocol) | Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string \| number` |  | yes |
| <a name="self"></a> [self](#input\_self) | Whether the security group itself will be added as a source to this ingress rule.  | `bool` |  | no |
| <a name="cidr_blocks"></a> [cidr_blocks](#input\_cidr\_blocks) | List of IPv4 CIDR blocks | `list(string)` |  | no |
| <a name="ipv6_cidr_blocks"></a> [ipv6_cidr_blocks](#input\_ipv6\_cidr\_blocks) | List of IPv6 CIDR blocks. | `list(string)` |  | no |
| <a name="source_security_group_id"></a> [source_security_group_id](#input\_source\_security\_group\_id) | Security group id to allow access to/from | `string` |  | no |


### Outputs

| Name | Type | Description |
|:------|:------|:------|
| <a name="arn"></a> [arn](#output\_arn) | `string` | The ARN of the serverless MSK cluster. |
| <a name="sg_id"></a> [arn](#output\_sg\_id) | `string` | The Security Group ID associated to MSK. |

### Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-msk-serverless/graphs/contributors).

