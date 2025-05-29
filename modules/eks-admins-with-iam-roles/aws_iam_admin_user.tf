
data "aws_iam_policy" "administrator_policy" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "admin_user" {
  name          = var.eks_admin_user
  path          = "/"
  force_destroy = true
  tags          = merge(var.common_tags, { Name = "${var.naming_prefix}-${var.eks_admin_user}" })
}

resource "aws_iam_user_policy_attachment" "admin_user_policy" {
  user       = aws_iam_user.admin_user.name
  policy_arn = data.aws_iam_policy.administrator_policy.arn
}