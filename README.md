Final Project: DevOps Course

Overview
This repository is the result of a comprehensive DevOps course project,the entire journey "from push to deploy" of a full-stack application. 
It demonstrates the integration of Continuous Integration (CI) and Continuous Deployment (CD) practices with infrastructure as code. 
The project involves setting up a VPC, EKS cluster, Kubernetes resources, and the automated deployment of a React application with its associated backend, frontend, and MySQL database through Argo CD.

Architecture
The project employs GitHub Actions to orchestrate the workflow, which is comprised of:

1. **Continuous Integration**: With each push, a CI pipeline is activated to validate code quality and successful builds.
2. **Infrastructure Provisioning**: Following a successful CI run, an infrastructure pipeline is triggered, utilizing Terraform modules housed in a separate repository named `final-project-modules`. These are managed with Terragrunt to facilitate deployment automation.
3. **Continuous Deployment**: Post infrastructure setup, a CD pipeline deploys the React application and its components on the Kubernetes cluster using Argo CD.

The CD pipeline with Argo CD is crucial as it ensures that any changes pushed to the respective branches are automatically deployed to the corresponding `dev` or `staging` environment. This means a push to the `dev` branch triggers the deployment only on the development infrastructure, and similarly for `staging`. on push to main both environments will be built.

Technologies Used
- **Terraform**: For declarative infrastructure as code.
- **Terragrunt**: To keep Terraform code DRY and to manage the state effectively.
- **Argo CD**: For the continuous delivery pipeline, ensuring that the latest changes are automatically reflected in the Kubernetes cluster.
- **EKS**: Amazon Elastic Kubernetes Service to orchestrate containerized applications.
- **GitHub Actions**: To automate CI/CD pipelines, enabling seamless "from push to deploy" workflows.
- **Prometheus & Grafana**: For monitoring and observability of both the Kubernetes cluster and the deployed applications.



