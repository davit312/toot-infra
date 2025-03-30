# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

data "aws_lb" "ingress_lb" {
  tags = {
    "kubernetes.io/service-name" : "ingress-nginx/ingress-nginx-controller"
  }

  depends_on = [helm_release.ingress-nginx]
}