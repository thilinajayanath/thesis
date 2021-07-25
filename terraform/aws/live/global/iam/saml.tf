resource "aws_iam_saml_provider" "keycloak" {
  name                   = "keycloak"
  saml_metadata_document = file("secrets/keycloak/idp-metadata.xml")
}
