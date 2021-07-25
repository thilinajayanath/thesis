data "terraform_remote_state" "networking" {
  backend = "s3"

  config = {
    bucket         = "thilina-thesis-cd-terraform-state"
    key            = "aws/cd/eu-west-1/networking/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    profile        = "cd"
  }
}
