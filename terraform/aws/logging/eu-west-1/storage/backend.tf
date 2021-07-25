terraform {
  backend "s3" {
    bucket         = "thilina-thesis-logging-terraform-state"
    key            = "aws/logging/eu-west-1/storage/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    profile        = "logging"
  }
}
