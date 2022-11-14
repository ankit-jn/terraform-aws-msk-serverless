variable "cluster_name" {
    description = "(Required) The name of the serverless cluster."
    type = string
    
}
## Ensure that the Virtual Private Clouds (VPCs) that you select have 
## DNS hostnames and DNS resolution enabled.
variable "vpc_configs" {
    description = <<EOF
VPC Configuration List where each entry should have the following property defined:

vpc_id      : (Optional) The ID of VPC that is used to create Security Group. Required only when `create_sg` is set `true`
              Type    : string
              Default : null

subnets     : (Required) A list of subnets in at least two different Availability Zones that host the client applications.
              Type    : list(string)
              
create_sg   : (Optional) Flag to decide to create Security Group in the VPC for MSK.
              Type    : bool
              Default : false

sg_name     : (Optional) The name of the Security group.
              Type    : string
              Default : null

sg_rules    : (Optional) Map of Security Group Rules with 2 Keys ingress and egress.
              The value for each key will be a list of Security group rules where 
              each entry of the list will again be a map of SG Rule Configuration	
              SG Rules Configuration: Refer (https://github.com/arjstack/terraform-aws-security-groups/blob/v1.0.0/README.md#security-group-rule--ingress--egress-)
              Default : {}

sg_tags     : (Optional) A map of tags to assign to SG. 
              Type    : map(string)
              Default : {}

additional_sg: (Optional) List of Existing Security Group IDs associated with MSK.
              Type    : list(string)
              Default : []

EOF
    type = any

    validation {
        condition = (try(length(var.vpc_configs), 0) > 0)
        error_message = "At least 1 VPC configuration is required for the serverless cluster."
    }

    validation {
        condition = (try(length(var.vpc_configs), 0) <= 5)
        error_message = "You can not add more than 5 VPC configurations for the serverless cluster."
    }
}

variable "configure_iam_policy" {
    description = "Flag to decide if IAM Policy should also be configured."
    type        = bool
    default     = true
}

variable "account_id" {
    description = "Account ID where MSK cluster is provisioned."
    type        = string
    default     = null
}

variable "region" {
    description = "Region Name where MSK cluster is provisioned."
    type        = string
    default     = null
}

variable "policy_name" {
    description = "IAM Policy Name created for the cluster."
    type        = string
    default     = null
}

variable "tags" {
    description = "(Optional) A map of tags to assign to MSK."
    type = map
    default = {}
}