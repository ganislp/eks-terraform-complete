


resource "aws_iam_user" "basic_user" {
  name          = var.eks_basic_user
  path          = "/"
  force_destroy = true
  tags          = merge(var.common_tags, { Name = "${var.naming_prefix}-${var.eks_basic_user}" })
}


resource "aws_iam_user_policy" "basic_user_eks_policy" {
  user = aws_iam_user.basic_user.name
  name = "${var.naming_prefix}-eks-full-access-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:ListRoles",
          "eks:*",
          "ssm:GetParameter"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

}

# resource "aws_iam_user_policy_attachment" "admin_user_policy" {
#   user = aws_iam_user.basic_user.name
#   policy_arn = data.aws_iam_policy.administrator_policy.arn
# }