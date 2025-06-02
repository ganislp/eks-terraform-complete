# Resource: ACM Certificate
resource "aws_acm_certificate" "acm_cert" {
  domain_name       = "*.kywaytechsolutions.com"
  validation_method = "DNS"

  tags = {
    Environment = "dev"
  }

  lifecycle {
    create_before_destroy = true
  }
}