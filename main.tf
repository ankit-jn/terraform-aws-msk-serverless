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

    dynamic "vpc_config" {
        for_each = var.vpc_configs

        content {
            subnet_ids = vpc_config.value.subnets
            security_group_ids =  lookup(vpc_config.value, "create_sg", false) ? concat([module.msk_security_group[vpc_config.value.vpc_id].security_group_id], 
                                                                        lookup(vpc_config.value, "additional_sg", [])) : lookup(vpc_config.value, "additional_sg", [])
        }
    }
    
    tags = merge({"Name" = var.cluster_name}, var.tags)
}

## Security Group for MSK
module "msk_security_group" {
    source = "git::https://github.com/arjstack/terraform-aws-security-groups.git?ref=v1.0.0"

    for_each = local.security_groups

    vpc_id = each.key
    name = coalesce(lookup(each.value, "sg_name", ""), format("%s-%s-sg", var.cluster_name, each.key))

    ingress_rules = flatten([ for rule_key, rule in lookup(each.value, "sg_rules", {}) : rule if rule_key == "ingress" ])
    egress_rules  = flatten([ for rule_key, rule in lookup(each.value, "sg_rules", {}) : rule if rule_key == "egress" ])
}

resource aws_iam_policy "this" {

    count = var.configure_iam_policy ? 1 : 0
    name = coalesce(var.policy_name, format("%s-policy", var.cluster_name))

    policy = data.aws_iam_policy_document.this[0].json
}

## Kafka IAM Policy documents
data aws_iam_policy_document "this" {
    count = var.configure_iam_policy ? 1 : 0

    statement {
        sid    = "MSKConnectAccess"
        effect = "Allow"

        actions = [
            "kafka-cluster:Connect"
        ]

        resources = [
            "arn:aws:kafka:${local.region}:${local.account_id}:cluster/${var.cluster_name}/*"
        ]
    }

    statement {
        sid    = "MSKTpoicAccess"
        effect = "Allow"

        actions = [
            "kafka-cluster:DescribeTopic",
            "kafka-cluster:CreateTopic",
            "kafka-cluster:WriteData",
            "kafka-cluster:ReadData"
        ]

        resources = [
            "arn:aws:kafka:${local.region}:${local.account_id}:topic/${var.cluster_name}/*"
        ]
    }

    statement {
        sid    = "MSKGroupAccess"
        effect = "Allow"

        actions = [
            "kafka-cluster:AlterGroup",
            "kafka-cluster:DescribeGroup"
        ]

        resources = [
            "arn:aws:kafka:${local.region}:${local.account_id}:group/${var.cluster_name}/*"
        ]
    }
}