variable "vpc_site_name" {
    type = string
    description = "Name for VPC site"
}

variable "aws_region" {
  type        = string
  description = "AWS Region where Site will be created"
}

variable "aws_instance_type" {
  type        = string
  description = "AWS instance type used for the Volterra site"
  default     = "t3.2xlarge"
}

variable "aws_hw_type" {
    type = string
    description = "Name of the AWS certified HW type"
    default = "aws-byol-multi-nic-voltmesh"
}

variable "aws_az" {
  type        = string
  description = "AWS Availability Zone e.g. us-east-1a"
}

variable "aws_disk_size" {
  type        = number
  description = "Disk size in GiB"
  default     = 80
}

variable "primary_ipv4" {
  type = string
  description = "Primary VPC address space"
}

variable "inside_subnet" {
  type = string
  description = "Inside subnet in CIDR notation"
}

variable "outside_subnet" {
  type = string
  description = "Outside subnet in CIDR notation"
}

variable "aws_credential_name" {
  type = string
}

variable "aws_iam_access_key" {
  type = string
}

variable "aws_iam_secret_key" {
  type = string
}