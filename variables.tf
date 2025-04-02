variable "cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
  default     = "k8-toot"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_types" {
  description = "Instance types for the EKS node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32"
}

variable "addons_version" {
  default = {
    vpc_cni            = "v1.19.2-eksbuild.5"
    coredns            = "v1.11.4-eksbuild.2"
    kube_proxy         = "v1.32.0-eksbuild.2"
    ebs_csi_driver     = "v1.41.0-eksbuild.1"
  }
}
