# Create custom GCP role for deploying TF resources: ref https://gitlab.com/volterra.io/cloud-credential-templates/-/blob/master/gcp/f5xc_gcp_vpc_role.yaml

resource "google_project_iam_custom_role" "volterra_custom_role" {
  role_id     = var.role_id
  title       = var.role_title
  description = "Volterra deployment role"
  permissions = [
    "compute.backendServices.create",
    "compute.backendServices.delete",
    "compute.backendServices.get",
    "compute.backendServices.list",
    "compute.disks.create",
    "compute.disks.delete",
    "compute.disks.get",
    "compute.disks.list",
    "compute.disks.resize",
    "compute.firewalls.create",
    "compute.firewalls.delete",
    "compute.firewalls.get",
    "compute.firewalls.list",
    "compute.firewalls.update",
    "compute.forwardingRules.create",
    "compute.forwardingRules.delete",
    "compute.forwardingRules.get",
    "compute.forwardingRules.list",
    "compute.globalOperations.get",
    "compute.healthChecks.create",
    "compute.healthChecks.delete",
    "compute.healthChecks.get",
    "compute.healthChecks.list",
    "compute.healthChecks.useReadOnly",
    "compute.images.create",
    "compute.images.get",
    "compute.images.list",
    "compute.images.useReadOnly",
    "compute.instanceGroupManagers.create",
    "compute.instanceGroupManagers.delete",
    "compute.instanceGroupManagers.get",
    "compute.instanceGroupManagers.list",
    "compute.instanceGroupManagers.update",
    "compute.instanceGroups.create",
    "compute.instanceGroups.delete",
    "compute.instanceGroups.get",
    "compute.instanceGroups.list",
    "compute.instanceGroups.use",
    "compute.instanceTemplates.create",
    "compute.instanceTemplates.delete",
    "compute.instanceTemplates.get",
    "compute.instanceTemplates.list",
    "compute.instanceTemplates.useReadOnly",
    "compute.instances.attachDisk",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.instances.deleteAccessConfig",
    "compute.instances.detachDisk",
    "compute.instances.get",
    "compute.instances.list",
    "compute.instances.reset",
    "compute.instances.resume",
    "compute.instances.setLabels",
    "compute.instances.setMachineResources",
    "compute.instances.setMachineType",
    "compute.instances.setMetadata",
    "compute.instances.setServiceAccount",
    "compute.instances.setTags",
    "compute.instances.start",
    "compute.instances.stop",
    "compute.instances.update",
    "compute.instances.updateAccessConfig",
    "compute.instances.updateNetworkInterface",
    "compute.instances.use",
    "compute.machineTypes.list",
    "compute.networkEndpointGroups.attachNetworkEndpoints",
    "compute.networks.access",
    "compute.networks.create",
    "compute.networks.delete",
    "compute.networks.get",
    "compute.networks.list",
    "compute.networks.update",
    "compute.networks.updatePolicy",
    "compute.networks.use",
    "compute.networks.useExternalIp",
    "compute.regionBackendServices.create",
    "compute.regionBackendServices.delete",
    "compute.regionBackendServices.get",
    "compute.regionBackendServices.list",
    "compute.regionBackendServices.use",
    "compute.regionOperations.get",
    "compute.routes.create",
    "compute.routes.delete",
    "compute.routes.get",
    "compute.routes.list",
    "compute.subnetworks.create",
    "compute.subnetworks.delete",
    "compute.subnetworks.get",
    "compute.subnetworks.list",
    "compute.subnetworks.setPrivateIpGoogleAccess",
    "compute.subnetworks.update",
    "compute.subnetworks.use",
    "compute.subnetworks.useExternalIp",
    "compute.zones.get",
    "iam.serviceAccounts.actAs",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.list",
    "resourcemanager.projects.get"
  ]
}

data "google_compute_default_service_account" "default" {
}

resource "google_service_account" "sa" {
  account_id   = "volterra-deployment"
  display_name = "Volterra deployment service account"
}

# Creation of service accounts is eventually consistent, and that can lead to errors when you try to apply ACLs to service accounts immediately after creation. Adding sleep to solve.
resource "time_sleep" "wait_n_seconds" {
  depends_on = [
    google_service_account.sa
  ]
  create_duration = var.sa_create_timeout
}

resource "null_resource" "next" {
  depends_on = [
    time_sleep.wait_n_seconds
  ]
}

resource "google_service_account_iam_member" "admin-account-iam" {
  service_account_id = google_service_account.sa.name
  role               = google_project_iam_custom_role.volterra_custom_role.id
  member             = "allAuthenticatedUsers"
}

# Allow SA service account use the default GCE account
resource "google_service_account_iam_member" "gce-default-account-iam" {
  service_account_id = data.google_compute_default_service_account.default.name
  role               = google_project_iam_custom_role.volterra_custom_role.id
  member             = "serviceAccount:${google_service_account.sa.email}"
}

# Export key for use in Cloud Credentials
resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.sa.name
}

# Volterra provider wants .key file
resource "local_file" "service_account" {
    content  = base64decode(google_service_account_key.mykey.private_key)
    filename = "volterrakey.key"
}