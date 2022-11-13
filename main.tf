## Provision Serverless MSK cluster
resource aws_msk_serverless_cluster "this" {

    cluster_name = var.cluster_name
    
    ## IAM based authentication
    client_authentication {
        sasl {
            iam {
                enabled = true
            }
        }
    }

    vpc_config {
        subnet_ids = var.subnets
        security_group_ids = local.security_groups
    }

    tags = merge({"Name" = var.cluster_name}, var.tags)
}

## Security Group for MSK
module "msk_security_group" {
    source = "git::https://github.com/arjstack/terraform-aws-security-groups.git?ref=v1.0.0"

    count = var.create_sg ? 1 : 0

    vpc_id = var.vpc_id
    name = local.sg_name

    ingress_rules = concat(local.sg_ingress_rules, local.sg_ingress_rules_source_sg)
    egress_rules  = local.sg_egress_rules
}