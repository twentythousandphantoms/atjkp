provider "aws" {
    profile = "default"
    region = "eu-north-1"
}

terraform {
  backend "s3" {
    bucket         = "atjkp"
    dynamodb_table = "terraform-state-lock"
    key            = "state/atjkp"
    region         = "eu-north-1"
  }
}
