variable "aws_region" {
  description = "AWS region to use for resources."
  type        = string
  default     = "us-east-1"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "CT"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
  default     = "Project"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources."
  default     = "demo"
}

variable "environment" {
  type        = string
  description = "Environment for deployment"
  default     = "dev"
}
