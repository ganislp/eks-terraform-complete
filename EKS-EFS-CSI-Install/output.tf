
output "efs_csi_iam_policy" {
  #value = data.http.efs_csi_iam_policy.body
  value = data.http.efs_csi_iam_policy.response_body
}

output "efs_csi_iam_role_arn" {
  description = "EFS CSI IAM Role ARN"
  value = aws_iam_role.efs_csi_iam_role.arn
}

# EFS CSI Helm Release Outputs
output "efs_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value = helm_release.efs_csi_driver.metadata
}
