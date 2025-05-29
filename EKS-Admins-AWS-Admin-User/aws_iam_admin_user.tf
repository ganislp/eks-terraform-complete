
data "aws_iam_policy" "administrator_policy" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "admin_user" {
  name          = "eksadmin1"
  path          = "/"
  force_destroy = true
  tags          = merge(local.common_tags, { Name = "${local.naming_prefix}-eksadmin1" })
}

resource "aws_iam_user_policy_attachment" "admin_user_policy" {
  user       = aws_iam_user.admin_user.name
  policy_arn = data.aws_iam_policy.administrator_policy.arn
}