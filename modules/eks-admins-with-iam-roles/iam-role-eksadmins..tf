
data "aws_caller_identity" "current" {

}

data "aws_iam_policy_document" "iam_trust_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

data "aws_iam_policy_document" "eks_admin_policy_document" {
  statement {
    effect = "Allow"
    actions = ["iam:ListRoles",
      "eks:*",
    "ssm:GetParameter"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "eks_admin_policy" {
  name        = "eks-admin-policy"
  description = "eks admin policy"
  policy      = data.aws_iam_policy_document.eks_admin_policy_document.json
}

resource "aws_iam_role" "eks_admin_role" {
  name               = var.eks_admin_role_name
  assume_role_policy = data.aws_iam_policy_document.iam_trust_policy_document.json
  tags               = merge(var.common_tags, { Name = "${var.naming_prefix}-${var.eks_admin_role_name}" })
}

resource "aws_iam_role_policy_attachment" "eks_admin_role_attachment" {
  role       = aws_iam_role.eks_admin_role.name
  policy_arn = aws_iam_policy.eks_admin_policy.arn
}




