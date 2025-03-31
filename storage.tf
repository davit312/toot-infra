data "aws_iam_policy_document" "csi" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.toot-eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.toot-eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_ebs_csi_driver" {
  assume_role_policy = data.aws_iam_policy_document.csi.json
  name               = "eks-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "amazon_ebs_csi_driver" {
  role       = aws_iam_role.eks_ebs_csi_driver.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

/* openid provider */

data "tls_certificate" "eks-toot" {
  url = aws_eks_cluster.toot-eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "toot-eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks-toot.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.toot-eks.identity[0].oidc[0].issuer
}
