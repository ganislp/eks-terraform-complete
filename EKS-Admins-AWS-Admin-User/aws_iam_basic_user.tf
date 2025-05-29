


resource "aws_iam_user" "basic_user" {
  name          = "eksadmin2"
  path          = "/"
  force_destroy = true
  tags          = merge(local.common_tags, { Name = "${local.naming_prefix}-eksadmin2" })
}


resource "aws_iam_user_policy" "basic_user_eks_policy" {
  user = aws_iam_user.basic_user.name
  name = "${local.naming_prefix}-eks-full-access-policy"
  policy = jsondecode({
    Version = "2012-10-17"
    Statements = [
      {
        Action = [
          "iam:ListRoles",
          "eks:*",
        "ssm:GetParameter"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# resource "aws_iam_user_policy_attachment" "admin_user_policy" {
#   user = aws_iam_user.basic_user.name
#   policy_arn = data.aws_iam_policy.administrator_policy.arn
# }