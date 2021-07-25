resource "aws_organizations_organization" "main_org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
  ]
  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
  ]
  feature_set = "ALL"
}

resource "aws_organizations_account" "cd" {
  name  = "thilina-thesis-cd"
  email = "dummyuser+cd@gmail.com"
}

resource "aws_organizations_account" "logging" {
  name  = "thilina-thesis-logging"
  email = "dummyuser+logging@gmail.com"
}

resource "aws_organizations_account" "live" {
  name  = "thilina-thesis-live"
  email = "dummyuser+live@gmail.com"
}

resource "aws_organizations_account" "test" {
  name  = "thilina-thesis-test"
  email = "dummyuser+test@gmail.com"
}
