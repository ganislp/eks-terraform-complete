output "irsa_iam_role_arn" {
  description = "IRSA IAM Role ARN"
  value = aws_iam_role.irsa_iam_role.arn
}
