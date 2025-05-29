resource "aws_iam_group" "eksreadonly_iam_group" {
  name = var.eks_read_only_group_name
  path = "/"
}

resource "aws_iam_group_policy" "eksreadonly_iam_group_assumerole_policy" {
  name  = "eksreadonly-group-policy"
  group = aws_iam_group.eksreadonly_iam_group.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Sid      = "AllowAssumeOrganizationAccountRole"
        Resource = "${aws_iam_role.eks_readonly_role.arn}"
      },
    ]
  })
}

resource "aws_iam_user" "eksreadonly_user" {
  name          = var.eksreadonly_user_name
  path          = "/"
  force_destroy = true
  tags          = merge(var.common_tags, { Name = "${var.eksreadonly_user_name}" })
}

resource "aws_iam_user" "eks_developer_user" {
  name          = var.eks_developer_user_name
  path          = "/"
  force_destroy = true
  tags          = merge(var.common_tags, { Name = "${var.eks_developer_user_name}" })
}

resource "aws_iam_group_membership" "eksreadonly" {
  group = aws_iam_group.eksreadonly_iam_group.name
  name  = "eksreadonly-group-membership"
  users = [aws_iam_user.eksreadonly_user.name,aws_iam_user.eks_developer_user.name]
}