locals{
    sg_name = coalesce(var.sg_name, format("%s-sg", var.cluster_name))
    
    sg_ingress_rules = flatten([ for rule_key, rule in var.sg_rules :  rule if rule_key == "ingress" ])
    sg_egress_rules = flatten([ for rule_key, rule in var.sg_rules :  rule if rule_key == "egress" ])

    additional_sg = coalesce(var.additional_sg, [])
    security_groups = var.create_sg ? concat([module.msk_security_group[0].security_group_id], 
                                                                local.additional_sg) : local.additional_sg
}