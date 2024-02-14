terraform {
  source = "git@github.com:ddriham/final-project-modules.git//argocd?ref=addons-v0.1.2"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  eks_name             = "dev-ddriham"
  enable_argo_cd       = true
  argo_cd_helm_version = "5.52.0"
  argo_cd_namespace    = "argocd"
  argo_cd_ingress_host = "dev-ddriham.argocd"
}

dependency "addons" {
  config_path = "../addons"
  
  mock_outputs = {
    eks_name = "ddriham-eks-cluster"
  }
}

generate "helm_provider" {
  path      = "helm-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
data "aws_eks_cluster" "eks" {
  name = var.eks_name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.eks_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}
EOF
}
generate "kube_provider" {
  path      = "kube.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "arn:aws:eks:us-east-2:343568180534:cluster/dev-ddriham"
}
EOF
}
