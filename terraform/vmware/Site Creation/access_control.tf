# Add User Permissions

data "vcd_org_user" "vapp_owner" {
  name = ""
}

resource "vcd_vapp_access_control" "ac" {

  vapp_id = vcd_vapp.vapp.id

  shared_with_everyone = false

  shared_with {
    user_id      = data.vcd_org_user.vapp_owner.id
    access_level = "FullControl"
  }
}
