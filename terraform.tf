variable "github_env" {
  type    = string
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
    tls = {
      source = "hashicorp/tls"
      version = "4.0.6"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.4-alpha.2"
    }
  }
  backend "s3" {
    bucket = "tfstate-7455"
    key    = "infrastructure-state"
    region = "us-west-2"
  }
}

provider "aws" {
  region  = "us-west-2"
  profile = var.github_env != "" ? "" : "terraform"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}
