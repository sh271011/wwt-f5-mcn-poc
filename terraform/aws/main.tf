terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.9"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.12.1"

    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "volterra" {
  api_p12_file = var.api_p12_file
  url          = var.api_url
}

provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  config_path = "./modules/k8s/kubeconfig-aws-sa.yaml"
}

module "volterra-namespace" {
  source = "./modules/volterra-namespace"
  name   = var.name
}

module "aws-iam" {
  source     = "./modules/aws-iam"
  username   = var.username
  policyname = var.policyname
  rolename   = var.rolename
}

module "volterra-vpc" {
  source                = "./modules/volterra-vpc"
  aws_credential_name   = module.aws-iam.iam_user_name
  aws_iam_access_key    = module.aws-iam.iam_access_key_id
  aws_iam_secret_key    = module.aws-iam.iam_access_key_secret
  vpc_site_name         = var.vpc_site_name
  aws_region            = var.aws_region
  aws_instance_type     = var.aws_instance_type
  aws_hw_type           = var.aws_hw_type
  aws_az                = var.aws_az
  aws_disk_size         = var.aws_disk_size
  primary_ipv4          = var.primary_ipv4
  inside_subnet         = var.inside_subnet
  outside_subnet        = var.outside_subnet
}

module "k8s" {
  source       = "./modules/k8s"
  k8snamespace = var.k8snamespace
  nodePort     = var.nodePort
}

module "volterra-lb" {
  source                = "./modules/volterra-lb"
  depends_on = [
    module.volterra-namespace
  ]
  originpool_name       = var.originpool_name
  originpool_namespace  = module.volterra-namespace.volterra_namespace_name
  origin_service_name   = format("%s.%s", module.k8s.k8s_app_name, module.k8s.k8s_namespace_name)
  origin_service_tenant = var.origin_service_tenant
  healthcheck_name      = var.healthcheck_name
  vpc_site_name = var.vpc_site_name
}