variable "user" {
  type        = string
  description = "REQUIRED:  Provide a vpshere username.  [administrator@vsphere.local]"
  default     = ""
}
variable "password" {
  type        = string
  description = "REQUIRED:  Provide a vsphere password."
  default     = ""
}
variable "vsphere_server" {
  type        = string
  description = "REQUIRED:  Provide a vsphere server or appliance. [vSphere URL (IP, hostname or FQDN)]"
  default     = ""
}
variable "datacenter" {
  type        = string
  description = "REQUIRED:  Provide a Datacenter Name."
  default     = ""
}
variable "vsphere_host_one" {
  type        = string
  description = "REQUIRED:  Provide a vcenter host. [vCenter URL (IP, hostname or FQDN)]"
  default     = ""
}
variable "datastore" {
  type        = string
  description = "REQUIRED:  Provide a Datastore Name."
  default     = ""
}
variable "resource_pool" {
  type        = string
  description = "REQUIRED:  Provide a Resource Pool Name."
  default     = "resource pool"

}
# Virtual Machine configuration

# Outside Network
variable "outside_network" {
  type        = string
  description = "REQUIRED:  Provide a Name for the Outside Interface Network. [ VM Network ]"
  default     = ""
}
variable "inside_network" {
  type        = string
  description = "REQUIRED:  Provide a Name for the Inside Interface Network. [  VM Network ]"
  default     = ""
}
# VM Number of CPU's
variable "cpus" {
  type        = number
  description = "REQUIRED:  Provide a vCPU count.  [ Not Less than 4, and do not limit each instance less than 2.9GHz ]"
  default     = 4
}
# VM Memory in MB
variable "memory" {
  type        = number
  description = "REQUIRED:  Provide RAM in Mb.  [ Not Less than 14336Mb ]"
  default     = 14336
}
#Guest Type
variable "guest_type" {
  type        = string
  description = "Guest OS Type: centos7_64Guest, other3xLinux64Guest"
  default     = "other3xLinux64Guest"
}
#OVA Path
variable "xcsovapath" {
  type        = string
  description = "REQUIRED: Path to XCS OVA. See https://docs.cloud.f5.com/docs/images/node-vmware-images"
  default     = ""
}
variable "node_password" {
  type        = string
  description = "REQUIRED:  Provide a vsphere password."
  default     = ""
}
## XCS Values
// Required Variable
variable "projectName" {
  type        = string
  description = "REQUIRED:  Provide a Prefix for use in F5 XCS created resources"
  default     = "project-name"
}
variable "tenant" {
  type        = string
  description = "REQUIRED:  Provide the F5 XCS Tenant name."
  default     = "xc tenant id"
}

variable "certifiedhardware" {
  type        = string
  description = "REQUIRED: XCS Certified Hardware Type: vmware-voltmesh, vmware-voltstack-combo, vmware-regular-nic-voltmesh, vmware-multi-nic-voltmesh, vmware-multi-nic-voltstack-combo"
  default     = "vmware-voltstack-combo"
}

variable "sitelatitude" {
  type        = string
  description = "REQUIRED: Site Physical Location Latitude. See https://www.latlong.net/"
  default     = ""
}
variable "sitelongitude" {
  type        = string
  description = "REQUIRED: Site Physical Location Longitude. See https://www.latlong.net/"
  default     = ""
}

variable "dnsservers" {
  description = "REQUIRED: XCS Site DNS Servers."
  type        = map(string)
  default = {
    primary   = ""
  }
}
variable "nodenames" {
  description = "REQUIRED: XCS Node Names."
  type        = map(string)
  default = {
    nodeone   = ""
  }
}
variable "clustername" {
  type        = string
  description = "REQUIRED: Site Cluster Name."
  default     = ""
}
variable "sitetoken" {
  type        = string
  description = "REQUIRED: Site Registration Token."
  default     = ""
}

variable "sitename" {
  type        = string
  description = "REQUIRED:  This is name for your deployment"
  default     = ""
}
// Required Variable
variable "api_p12_file" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./<your-api-creds-file>.p12"
}
variable "namespace" {
  type        = string
  description = "REQUIRED:  This is your volterra App Namespace"
  default     = ""
}
variable "api_url" {
  type        = string
  description = "REQUIRED:  This is your volterra API url"
  default     = "https://<uour-tenant-url>/api"
}