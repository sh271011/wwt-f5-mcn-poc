#!/usr/bin/env bash

export VES_P12_PASSWORD='123456'
export GCP_PROJECT_ID='gcp-atcpoc0006319-10008495'
export GCP_SA_NAME='account-name'
export GCP_ROLE_ID='role_id'

# Create user account here due to exporting issues in terraform
# Pull definitions
curl https://gitlab.com/volterra.io/cloud-credential-templates/-/raw/master/gcp/f5xc_gcp_vpc_role.yaml --output volterra_gcp_role.yaml

# Swap to correct project

gcloud config set project $GCP_PROJECT_ID

# Create role

gcloud iam roles create $GCP_ROLE_ID --project=$GCP_PROJECT_ID --file volterra_gcp_role.yaml

# Create service account

gcloud iam service-accounts create $GCP_SA_NAME --display-name $GCP_SA_NAME

# Export value of service account email

export GCP_SVC_EMAIL=`gcloud iam service-accounts list | grep $GCP_SA_NAME | awk '{print $2}'`

# Add created IAM policy to role

gcloud projects add-iam-policy-binding $GCP_PROJECT_ID --member='serviceAccount:'$GCP_SVC_EMAIL'' --role=projects/$GCP_PROJECT_ID/roles/$GCP_ROLE_ID

# Export key for service account to use in cloud creds

gcloud iam service-accounts keys create --iam-account $GCP_SVC_EMAIL volterrakey.json

# Run terraform script

terraform init
terraform plan
read -p "Press any key to continue..." -n1 -s
terraform apply --auto-approve