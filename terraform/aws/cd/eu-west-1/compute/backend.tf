terraform {
  backend "s3" {
    bucket         = "thilina-thesis-cd-terraform-state"
    key            = "aws/cd/eu-west-1/compute/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    profile        = "cd"
  }
}
