# Admin access
resource "aws_iam_role" "admin" {
  name = "admin-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : aws_iam_saml_provider.keycloak.arn
        },
        "Action" : "sts:AssumeRoleWithSAML",
        "Condition" : {
          "StringEquals" : {
            "SAML:aud" : "https://signin.aws.amazon.com/saml"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin" {
  role       = aws_iam_role.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "readonly" {
  name = "readonly-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : aws_iam_saml_provider.keycloak.arn
        },
        "Action" : "sts:AssumeRoleWithSAML",
        "Condition" : {
          "StringEquals" : {
            "SAML:aud" : "https://signin.aws.amazon.com/saml"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "readonly" {
  role       = aws_iam_role.readonly.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Access for Jenkins user
resource "aws_iam_role" "jenkins" {
  name = "jenkins"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::751493318674:role/jenkins-role"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "IpAddress" : { "aws:SourceIp" : "54.76.240.216" }
        }
      }
    ]
  })
}
