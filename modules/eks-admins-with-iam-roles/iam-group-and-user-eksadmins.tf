resource "aws_iam_group" "eks_admin_group" {
  name = var.eks_admin_group_name
  path = "/"
}

resource "aws_iam_group_policy" "eksadmins_iam_group_assumerole_policy" {
  name  = "eksadmins-group-policy"
  group = aws_iam_group.eks_admin_group.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Sid      = "AllowAssumeOrganizationAccountRole"
        Resource = "${aws_iam_role.eks_admin_role.arn}"
      },
    ]
  })
}

resource "aws_iam_user" "eks_role_admin_user" {
  name          = "eksadmin2"
  path          = "/"
  force_destroy = true
  tags          = merge(var.common_tags, { Name = "eksadmin2" })
}



resource "aws_iam_group_membership" "eksadmins" {
  name  = "eksadmins-group-membership"
  users = [aws_iam_user.eks_role_admin_user.name]
  group = aws_iam_group.eks_admin_group.name
}