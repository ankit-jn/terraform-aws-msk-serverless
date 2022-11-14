## ARJ-Stack: Serverless Amazon Managed Streaming for Apache Kafka (MSK) Terraform module

A Terraform module for configuring Serverless Amazon Managed Streaming for Apache Kafka

### Resources

This module features the following components to be provisioned with different combinations:

- Amazon MSK Cluster [[aws_msk_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster)]
- IAM Policy [[aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)]
    - IAM Policy for Working with MSK Cluster, Topic, Groups
- Security Group [[aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)]
    - Security Group for each VPC to be attached with MSK
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

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="cluster_name"></a> [cluster_name](#input\_cluster\_name) | The name of the serverless cluster. | `string` |  | yes |
| <a name="vpc_configs"></a> [vpc_configs](#vpc\_configs) | VPC Configuration List to be associated with the serverless cluster. | `string` |  | yes |
| <a name="configure_iam_policy"></a> [configure_iam_policy](#input\_configure\_iam\_policy) | Flag to decide if IAM Policy should also be configured. | `bool` | `true` | no |
| <a name="account_id"></a> [account_id](#input\_account\_id) | Account ID where MSK cluster is provisioned. Default is picked as Caller's account | `string` | `null` | no |
| <a name="region"></a> [region](#input\_region) | Region Name where MSK cluster is provisioned. Default is picked as Curent Region | `string` | `null` | no |
| <a name="policy_name"></a> [policy_name](#input\_policy\_name) | IAM Policy Name created for the cluster. | `string` | `null` | no |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to MSK. | `map(string)` | `{}` | no |

### Nested Configuration Maps:  

#### vpc_configs

- 5 VPC configs are allowed to be associated with MSK serverless cluster
- Ensure that the Virtual Private Clouds (VPCs) that you select have DNS hostnames and DNS resolution enabled.
- At least one of following is required 
    - `create_sg` set as `true`
    - At least a single entry in `additional_sg` list

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="vpc_id"></a> [vpc_id](#input\_vpc\_id) | The ID of VPC that is used to create Security Group.  Required only when `create_sg` is set `true` | `string` | `null` | no |  |
| <a name="subnets"></a> [subnets](#input\_subnets) | A list of subnets in at least two different Availability Zones that host the client applications. | `list(string)` |  | yes |  |
| <a name="create_sg"></a> [create_sg](#input\_create\_sg) | Flag to decide to create Security Group for MSK. | `bool` | `false` | no |  |
| <a name="sg_name"></a> [sg_name](#input\_sg\_name) | The name of the Security group. | `string` | `null` | no |  |
| <a name="sg_rules"></a> [sg_rules](#sg\_rules) | Configuration Map for Security Group Rules | `map` | `{}` | no | <pre>{<br>   ingress = [<br>      {<br>        rule_name = "Self Ingress Rule"<br>        description = "Self Ingress Rule"<br>        from_port =0<br>        to_port = 0<br>        protocol = "-1"<br>        self = true<br>      },<br>      {<br>        rule_name = "Ingress from IPv4 CIDR"<br>        description = "IPv4 Rule"<br>        from_port = 443<br>        to_port = 443<br>        protocol = "tcp"<br>        cidr_blocks = ["xx.xx.xx.xx/xx"]<br>      }<br>   ]<br>   egress =[<br>      {<br>        rule_name = "Self Egress Rule"<br>        description = "Self Egress Rule"<br>        from_port =0<br>        to_port = 0<br>        protocol = "-1"<br>        self = true<br>      }<br>   ]<br>} |
| <a name="sg_tags"></a> [sg_tags](#input\_sg\_tags) | A map of tags to assign to SG. | `map(string)` | `{}` | no |  |
| <a name="additional_sg"></a> [additional_sg](#input\_additional\_sg) | List of Existing Security Group IDs associated with MSK. | `list(string)` | `[]` | no |  |

### Nested Configuration Maps:

#### sg_rules
[ Ingress / Egress ]

- Map of Security Group Rules with 2 Keys `ingress` and `egress`.
- The value for each key will be a list of Security group rules where each entry of the list will again be a map of SG Rule Configuration

Refer [SG Rules Configuration](https://github.com/arjstack/terraform-aws-security-groups/blob/v1.0.0/README.md#security-group-rule--ingress--egress-) for the structure


### Outputs

| Name | Type | Description |
|:------|:------|:------|
| <a name="arn"></a> [arn](#output\_arn) | `string` | The ARN of the serverless MSK cluster. |
| <a name="policy_arn"></a> [policy_arn](#output\_policy\_arn) | `string` | The ARN assigned by AWS to this policy. |
| <a name="security_groups"></a> [arn](#output\_security\_groups) | `map(string)` | The Security Group ID for each VPC, associated to MSK. |

### Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-msk-serverless/graphs/contributors).

