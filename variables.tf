variable "cluster_name" {
    description = "(Required) The name of the serverless cluster."
    type = string
    
}

variable "vpc_id" {
    description = <<EOF
(Optional) The ID of VPC that is used to create Security Group. 
Required only where `create_sg` is set `true`
EOF
    type = string
    default = null
}

variable "subnets" {
    description = "A list of subnets in at least two different Availability Zones that host the client applications."
    type = list(string)
}

variable "create_sg" {
    description = "Flag to decide to create Security Group for MSK"
    type        = bool
    default     = false
}

variable "sg_name" {
    description = "The name of the Security group"
    type        = string
    default     = null
}

variable "sg_rules" {
    description = <<EOF

(Optional) Configuration Map for Security Group Rules of Security Group:
It is a map of Rule Pairs where,
Key of the map is Rule Type and Value of the map would be an array of Security Rules Map 
There could be 2 Rule Types [Keys] : 'ingress', 'egress'

(Optional) Configuration List of Map for Security Group Rules where each entry will have following properties:

rule_name: (Required) The name of the Rule (Used for terraform perspective to maintain unicity)
description: (Optional) Description of the rule.
from_port: (Required) Start port (or ICMP type number if protocol is "icmp" or "icmpv6").
to_port: (Required) End port (or ICMP code if protocol is "icmp").
protocol: (Required) Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number

self: (Optional) Whether the security group itself will be added as a source to this ingress rule. 
cidr_blocks: (Optional) List of IPv4 CIDR blocks
ipv6_cidr_blocks: (Optional) List of IPv6 CIDR blocks.
source_security_group_id: (Optional) Security group id to allow access to/from
 
Note: 
1. `cidr_blocks` Cannot be specified with `source_security_group_id` or `self`.
2. `ipv6_cidr_blocks` Cannot be specified with `source_security_group_id` or `self`.
3. `source_security_group_id` Cannot be specified with `cidr_blocks`, `ipv6_cidr_blocks` or `self`.
4. `self` Cannot be specified with `cidr_blocks`, `ipv6_cidr_blocks` or `source_security_group_id`.

EOF
    default = {}
}

variable "additional_sg" {
    description = "(Optional) List of Existing Security Group IDs associated with MSK."
    type        = list(string)
    default     = []
}

variable "tags" {
    description = "(Optional) A map of tags to assign to MSK."
    type = map
    default = {}
}