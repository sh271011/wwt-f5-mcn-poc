## Automating the Infrastructure deployment using terraform

Many of the steps we deployed can be automated using Terraform to deploy resources within the 3 different cloud providers (GCP, AWS, and Azure). Example templates have been developed to automate deployment in a similar method to what has been outlined in the runbook at this current time. This section will outline the steps and requirements for running the pre-requisite Terraform code. 

Additional information regarding the Volterra Terraform provider can be found here: https://registry.terraform.io/providers/volterraedge/volterra/latest/docs

### Prerequisites
Due to limitations in providers, you will need to have the GCP CLI tool installed:

https://cloud.google.com/sdk/docs/install

Azure deployments will require a pre-existing Azure Service Principal with the appropriate permisisons assigned to them as outlined earlier in the runbook. 

### Environment Variables

To run this project, you will need to add the following environment variables:

**AWS**

`AWS_ACCESS_KEY_ID`

`AWS_SECRET_ACCESS_KEY`

`AWS_SESSION_TOKEN`

`VES_P12_PASSWORD` - Password to Volterra certificate

**Azure**

`VES_P12_PASSWORD` - Password to Volterra certificate

**GCP**

Modify the environmental variables within the `deployment.sh` script.

### Deployment

To deploy this project run, enter the folder for the cloud provider you want to deploy to.

Create a `terraform.tfvars` file within the root folder and enter all of the environmental variables. Alternatively, you can run the terraform and input the variables interactively. 

**NOTE:** Some variables have defaults set. Double check all defaults to ensure they fit your deployment parameters.

Within the `main.tf` file, uncomment the namespace creation section if one does not already exist and you want to create a new namespace within the Volterra console.

From within the root folder, run the following commands:

```bash
  terraform init
  terraform plan
  terraform apply
```

### GCP Specific Deployment

Due to limitations in the providers, it is necessary to deploy the GCP environment using a shell script. 

Follow the instructions as above for modifying any variables and creating your `terraform.tfvars` file. Make sure to open the `deployment.sh` file and modify any variables as needed.

Ensure that you have the GCP CLI installed. Browse to the root gcp folder and run

```bash
./deployment.sh
```

This deployment script will attempt to run a `terrform init` and `terraform apply` for you.

Additional requirements for AppStack deployment has also been commented in the applicable sections of the `main.tf` file.

### Volterra HTTP Load Balancer Creation

Once the deployment is complete, you will need to create a new HTTP Load Balancer within the Volterra console. This can be automated using the Volterra provider and the code supplied within the `terraform\volterra` folder.

#### Delegating the domain to F5XC

Before we create the proxy loadbalancer, we will need to delegate a subdomain to F5XC platform. You can follow the steps mentioned in [Step 3: Create the Front end HTTP Load Balancer](../clouds/proxy_lb.md#step-3\:-create-the-front-end-http-load-balancer) to perform this task.

### File Locations

The following files are expected in the following locations:

`volterrakey.json` - GCP Service Account key, located in `/`

`volterra-api-creds.p12` - Certificate to authenticate to Volterra console, located in `/`

`kubeconfig.yaml` - Kubeconfig for AKS/EKS/GKE/K8S clusters, located within the `modules/k8s` folder for the specified cloud provider.

### Credentials

The Terraform/Deployment scripts will handle the creation of a new Service Account/Role as necessary for each of the cloud providers, eXCept Azure (WIP).

If existing credentials already exist, replace their values in your `.tfvars` file or comment out any IAM modules.