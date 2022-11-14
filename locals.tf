locals{
    security_groups = { for vpc_config in var.vpc_configs: 
                            vpc_config.vpc_id => vpc_config if lookup(vpc_config, "create_sg", false) }

    account_id = coalesce(var.account_id, data.aws_caller_identity.current.account_id)
    region = coalesce(var.region, data.aws_region.current.name)
}