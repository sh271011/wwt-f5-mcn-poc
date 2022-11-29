## Execution steps

This terraform code allows the engineer to provision a VMware site template from the VCloud environment and also deploy & register the **F5XC cloudmesh node** in the **F5XC teant**.

The execution will proceed in two stages as below.

- First stage involves VMware site creation
- Second stage involves deploying & registering the cloudmesh node locally from the Site Jumpbox

### Deploying the base VMware Site

You will need to execute the terraform code in directory **Site Creation** to provision the **base-template**. Once the Site is provisioned & Powered ON, verifiy that all VM's are functional, wait for the VM's to be fully booted up. The vSphere server usually takes 5 to 10 mins to be fully functional.

Also make sure you update the below variables.

"vapp_owner" in the [access_control.tf](vapp/access_control.tf) to appropriate user id, so the vApp gets assigned to the right resource.
```json
data "vcd_org_user" "vapp_owner" {
  name = "<owner AD ID>"
}
```

"vcd_user" in the [vars.tf](vapp/vars.tf), this can be a serviceaccount or individual account with admin access to the VSphere environment.
```json
variable "vcd_user" {
  type        = string
  description = "vCD user"
  sensitive = true
  default = ""
}
```

"vcd_pass" in the [vars.tf](vapp/vars.tf), this can be a serviceaccount password or individual password.
```json
variable "vcd_pass" {
  type        = string
  description = "vCD password"
  sensitive = true
  default = ""
}
```

!!! Note

    Depending on the environment from where you are executing this code, it might take somewhere between 35 to 40 minutes to complete the Site creation.

### Deploying the cloudmesh node from the Site Jumpbox

The terraform code to deploy the cloudmesh node is stored in directory **cloudmeshnode**, depending on your tenant you might have to update some of the variables in the [variables.tf](cloudmeshnode/variables.tf) file as below.

```json
variable "sitetoken" {
  type        = string
  description = "REQUIRED: Site Registration Token."
  default     = "xxxxxxxxxxxxxxxx"
}
```
*This variable value is captured from F5XC tenant Dashboard and pre-populated in the variable file, depending on your deployment the value can change. This sitetoken allows the F5XC platform to identify your cloudmesh node and register it successfully on the platform*

```json
variable "api_url" {
  type        = string
  description = "REQUIRED:  This is your volterra API url"
  default     = "https://<your tenant url>/api"
}
```
*This is the url to access your F5XC tenant*

```json
variable "api_p12_file" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api-creds.p12"
}
```
*This is used to authenticate to the F5XC platform, pls refer the link in the variable description on creating this file for your environment, you will also need to configure an environment variable **VES_P12_PASSWORD** to decrypt the credentials file*

The base template **volterra-mcn-base-template** is already configured with **api_p12_file** and environment variable is also setup to correct value, so when you clone this vApp, you can skip these settings or update them as per your environment. The **api_creds.p12** file is under **jumpbox downloads** folder, you will need to import this file into the **cloudmesh** directory before executing the code.