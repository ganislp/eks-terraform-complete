locals {
  common_tags = {
    company     = var.company
    project     = "${var.company}-${var.project}"
    environment = var.environment
    createdBy   = "Terraform"
  }
  name = "${var.naming_prefix}-${var.environment}"
}