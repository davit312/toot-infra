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

resource "aws_eks_addon" "csi_driver" {
  cluster_name             = aws_eks_cluster.toot-eks.name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = var.addons_version.ebs_csi_driver
  service_account_role_arn = aws_iam_role.eks_ebs_csi_driver.arn
}