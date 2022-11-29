variable "username" {
    type = string
    description = "New IAM user for cloud deployments"
}

variable "policyname" {
    type = string
    description = "Name for Volterra deploy policy."
}

variable "rolename" {
    type = string
    description = "Name for AWS Role for policy attachment."
}