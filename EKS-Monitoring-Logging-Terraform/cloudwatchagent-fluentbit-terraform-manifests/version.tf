terraform {
  required_version = "~> 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.9"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.37"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.3"
    }

       kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }   

  }
}