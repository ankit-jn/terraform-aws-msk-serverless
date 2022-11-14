output "arn" {
    description = "The ARN of the serverless MSK cluster."
    value       = aws_msk_serverless_cluster.this.arn 
}

output "security_groups" {
    description = "The Security Group ID associated to MSK."
    value       = { for vpc_config in var.vpc_configs: 
                            vpc_config.vpc_id => module.msk_security_group[vpc_config.vpc_id].security_group_id
                                    if lookup(vpc_config, "create_sg", false) } 
}

output "policy_arn" {
    description = "The ARN assigned by AWS to this policy."
    value = var.configure_iam_policy ? aws_iam_policy.this[0].arn : ""
}