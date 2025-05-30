resource "aws_iam_policy" "lbc_iam_policy" {
  name   = "${local.naming_prefix}-AWSLoadBalancerControllerIAMPolicy"
  path   = "/"
  policy = data.http.lbc_iam_policy.body
}

resource "aws_iam_role" "lbc_iam_role" {
  name = "${local.naming_prefix}-lbc-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn}"
        }
        Condition = {
          StringEquals = {
            "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:aud" : "sts.amazonaws.com",
            "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:sub" : "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      },
    ]
  })
  tags = merge(local.common_tags, { Name = "${var.naming_prefix}-lbc-iam-role" })
}

resource "aws_iam_role_policy_attachment" "lbc_iam_role_policy_attach" {
  role       = aws_iam_role.lbc_iam_role.name
  policy_arn = aws_iam_policy.lbc_iam_policy.arn
}