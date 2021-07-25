terraform {
  backend "s3" {
    bucket         = "thilina-thesis-live-terraform-state"
    key            = "aws/live/global/iam/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    profile        = "live"
  }
}
