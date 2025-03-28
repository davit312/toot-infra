resource "aws_eks_cluster" "toot-eks" {
  name = var.cluster_name

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster-role.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = [
      aws_subnet.private-subnets[0].id,
      aws_subnet.private-subnets[1].id,
      aws_subnet.public-subnets[0].id,
      aws_subnet.public-subnets[1].id,
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

/** **/

resource "aws_iam_role" "cluster-role" {
  name = "toot-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster-role.name
}
