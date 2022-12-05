# gcp_terraform

The terraform directory contains terraform build and variable files.  If the terraform build files will be called from the platform, additional customization is needed. Please reach out to the ATC core team for information on the customization.

The files in this directory are an example on calling terraform from the platform to build resources in AWS.

## Generating the vK8s_kubeconfig file

For the purpose of this deployment we will be extracting the kubeconfig file from the F5XC SaaS Console.

Once you have deployed the Virtual site with appropriate namespace, you can follow **Step 6** from [Step 4: Creation of Virtual Site and Virtual K8s object for namespace mcn-walkthrough](../../clouds/gcp_cloud.md#step-4\:-creation-of-virtual-site-and-virtual-k8s-object-for-namespace-mcn-walkthrough) to download the **vk8s_kubeconfig** file.