terraform {
  backend "s3" {
    bucket         = "thilina-thesis-cd-terraform-state"
    key            = "aws/cd/global/iam/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    profile        = "cd"
  }
}
