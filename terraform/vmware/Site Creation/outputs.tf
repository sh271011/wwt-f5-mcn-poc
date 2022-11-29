output "vapp_ip" {
    value = vcd_vapp_nat_rules.vapp-nat.rule[0].external_ip
}
