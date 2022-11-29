# Create vApp
resource "vcd_vapp" "vapp" {
  name = ""
  description = "base template to create a new F5 DCS CE Site on ATC platform"
  power_on = true
}
