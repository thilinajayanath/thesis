resource "aws_organizations_policy" "deny_cloudtrail" {
  name = "deny-cloudtrail"

  content = file("scp.json")
}

resource "aws_organizations_policy_attachment" "root" {
  policy_id = aws_organizations_policy.deny_cloudtrail.id
  target_id = aws_organizations_organization.main_org.roots[0].id
}
