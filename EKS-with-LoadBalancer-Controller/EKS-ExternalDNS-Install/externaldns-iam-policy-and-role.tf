resource "aws_iam_role" "externaldns_iam_role" {
  name = "${local.naming_prefix}-externaldns-iam-role"
  assume_role_policy = jsonencode({
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
            "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:sub" : "system:serviceaccount:default:external-dns"
          }
        }
      },
    ]
  })
  tags = {
    tag-key = "AllowExternalDNSUpdates"
  }
}

resource "aws_iam_policy" "externaldns_iam_policy" {
  name        = "${local.naming_prefix}-AllowExternalDNSUpdates"
  path        = "/"
  description = "External DNS IAM Policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets"
        ],
        "Resource" : [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "name" {
  role       = aws_iam_role.externaldns_iam_role.name
  policy_arn = aws_iam_policy.externaldns_iam_policy.arn
}