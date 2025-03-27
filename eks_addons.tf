resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.toot-eks.name
  addon_name    = "vpc-cni"
  addon_version = var.addons_version.vpc_cni
}

resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.toot-eks.name
  addon_name    = "coredns"
  addon_version = var.addons_version.coredns
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = aws_eks_cluster.toot-eks.name
  addon_name    = "kube-proxy"
  addon_version = var.addons_version.kube_proxy
}
