output "arn" {
    description = "The ARN of the serverless MSK cluster."
    value       = aws_msk_serverless_cluster.this.arn 
}

output "sg_id" {
    description = "The Security Group ID associated to MSK."
    value       = var.create_sg ? module.msk_security_group[0].security_group_id : ""
}
