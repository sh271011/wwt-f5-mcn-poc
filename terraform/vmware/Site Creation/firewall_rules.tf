# Create Firewall Rules
resource "vcd_vapp_firewall_rules" "vapp-fw" {
  vapp_id        = vcd_vapp.vapp.id
  network_id     = vcd_vapp_network.Management.id
  default_action = "drop"
  enabled        = "true"
  log_default_action = "false"

  
  rule {
        name             =  "allow-rdp-access"
        policy           =  "allow"
        protocol         =  "tcp"
        source_ip        =  "any"
        source_port      =  "any"
        destination_ip   =  "any"
        destination_port =  "3389"
        enable_logging   =  "true"
      }

  rule {
        name             =  "allow-https-access"
        policy           =  "allow"
        protocol         =  "tcp"
        source_ip        =  "any"
        source_port      =  "any"
        destination_ip   =  "any"
        destination_port =  "8443"
        enable_logging   =  "true"
      }

  rule {
        name             =  "allow-on-net-access-in"
        policy           =  "allow"
        protocol         =  "tcp"
        source_ip        =  "any"
        source_port      =  "any"
        destination_ip   =  "any"
        destination_port =  "443"
        enable_logging   =  "true"
      }
      
  rule {
        name             =  "allow-on-net-access-in"
        policy           =  "allow"
        protocol         =  "any"
        source_ip        =  "10.252.0.0/14"
        source_port      =  "any"
        destination_ip   =  "internal"
        destination_port =  "any"
        enable_logging   =  "true"
      }

  rule {
        name             =  "allow-on-atc-vpn-in"
        policy           =  "allow"
        protocol         =  "any"
        source_ip        =  "172.31.1.0/24"
        source_port      =  "any"
        destination_ip   =  "internal"
        destination_port =  "any"
        enable_logging   =  "true"
      }

  rule {
        name             =  "allow-wwt-github-out"
        policy           =  "allow"
        protocol         =  "tcp"
        source_ip        =  "internal"
        source_port      =  "any"
        destination_ip   =  "10.6.34.174"
        destination_port =  "443"
        enable_logging   =  "true"
      }

  rule {
        name             =  "allow-wwt-gitlocal-out"
        policy           =  "allow"
        protocol         =  "tcp"
        source_ip        =  "internal"
        source_port      =  "any"
        destination_ip   =  "10.255.16.30"
        destination_port =  "80"
        enable_logging   =  "true"
      }

  rule {
        name             =  "allow-wwt-tfe-dev-out"
        policy           =  "allow"
        protocol         =  "tcp"
        source_ip        =  "internal"
        source_port      =  "any"
        destination_ip   =  "10.255.17.40"
        destination_port =  "443"
        enable_logging   =  "true"
      }

  rule {
        name             =  "allow-wwt-tfe-prod-out"
        policy           =  "allow"
        protocol         =  "tcp"
        source_ip        =  "internal"
        source_port      =  "any"
        destination_ip   =  "10.255.17.40"
        destination_port =  "443"
        enable_logging   =  "true"
      }

  rule {
        name             =  "allow-atc-dns-out"
        policy           =  "allow"
        protocol         =  "udp"
        source_ip        =  "internal"
        source_port      =  "any"
        destination_ip   =  "10.255.0.1"
        destination_port =  "53"
        enable_logging   =  "true"
      }

  rule {
        name             =  "allow-atc-ntp-out"
        policy           =  "allow"
        protocol         =  "udp"
        source_ip        =  "internal"
        source_port      =  "any"
        destination_ip   =  "10.255.0.1"
        destination_port =  "123"
        enable_logging   =  "true"
      }

  rule {
        name             =  "allow-atc-kms-out"
        policy           =  "allow"
        protocol         =  "tcp"
        source_ip        =  "internal"
        source_port      =  "any"
        destination_ip   =  "10.255.16.186"
        destination_port =  "1688"
        enable_logging   =  "true"
      }

  rule {
        name             =  "deny-192-net-out"
        policy           =  "drop"
        protocol         =  "any"
        source_ip        =  "internal"
        source_port      =  "any"
        destination_ip   =  "192.168.0.0/16"
        destination_port =  "any"
        enable_logging   =  "true"
      }

  rule {
        name             =  "deny-172-net-out"
        policy           =  "drop"
        protocol         =  "any"
        source_ip        =  "internal"
        source_port      =  "any"
        destination_ip   =  "172.16.0.0/12"
        destination_port =  "any"
        enable_logging   =  "true"
      }

  rule {
        name             =  "deny-10-net-out"
        policy           =  "drop"
        protocol         =  "any"
        source_ip        =  "internal"
        source_port      =  "any"
        destination_ip   =  "10.0.0.0/8"
        destination_port =  "any"
        enable_logging   =  "true"
      }

  rule {
        name             =  "Allow all outbound traffic"
        policy           =  "allow"
        protocol         =  "any"
        source_ip        =  "internal"
        source_port      =  "any"
        destination_ip   =  "external"
        destination_port =  "any"
        enable_logging   =  "true"
      }

  rule {
        name             =  "Default policy"
        policy           =  "drop"
        protocol         =  "any"
        source_ip        =  "any"
        source_port      =  "any"
        destination_ip   =  "any"
        destination_port =  "any"
        enable_logging   =  "true"
      }

}
