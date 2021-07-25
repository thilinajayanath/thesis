terraform {
  backend "s3" {
    bucket         = "thilina-thesis-root-terraform-state"
    key            = "aws/root/global/cloudtrail/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    profile        = "root"
  }
}
