# access-entries.tf — IAM principals allowed to call the Kubernetes API (replaces aws-auth for API mode)

data "aws_caller_identity" "current" {}

locals {
  cluster_admin_principal_arns = distinct(compact(concat(
    var.cluster_admin_principal_arns,
    var.include_caller_as_cluster_admin ? [data.aws_caller_identity.current.arn] : [],
  )))
}

resource "aws_eks_access_entry" "cluster_admin" {
  for_each = toset(local.cluster_admin_principal_arns)

  cluster_name  = aws_eks_cluster.this.name
  principal_arn = each.value
  type          = "STANDARD"

  tags = merge(
    local.base_tags,
    {
      Name = "${var.cluster_name}-admin-access"
    },
  )

  depends_on = [aws_eks_cluster.this]
}

resource "aws_eks_access_policy_association" "cluster_admin" {
  for_each = toset(local.cluster_admin_principal_arns)

  cluster_name  = aws_eks_cluster.this.name
  principal_arn = each.value
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.cluster_admin]
}
