resource "aws_eks_access_entry" "terraform_access" {
  cluster_name      = aws_eks_cluster.toot-eks.name
  principal_arn     = data.aws_caller_identity.current.arn
  kubernetes_groups = []
  type              = "STANDARD"
  user_name  = "terraform"
}

resource "aws_eks_access_policy_association" "terraform_policy" {
  cluster_name  = aws_eks_cluster.toot-eks.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = data.aws_caller_identity.current.arn

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.terraform_access]
}

resource "null_resource" "config-kubectl" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${aws_eks_cluster.toot-eks.name} --region ${var.region}"
  }

  triggers = {
    always = timestamp()
  }

  depends_on = [aws_eks_access_policy_association.terraform_policy]
}