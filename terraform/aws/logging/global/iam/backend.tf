terraform {
  backend "s3" {
    bucket         = "thilina-thesis-logging-terraform-state"
    key            = "aws/logging/global/iam/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    profile        = "logging"
  }
}
