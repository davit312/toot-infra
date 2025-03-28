variable "github_env" {
  type = string
  default = ""
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.0-pre2"
    }
  }
}

provider "aws" {
  region  = "us-west-2"
  profile = var.github_env == "" ? "" : "terraform"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}
