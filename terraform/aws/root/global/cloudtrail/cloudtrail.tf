resource "aws_cloudtrail" "organizational_trail" {
  name                       = "organizational-trail"
  s3_bucket_name             = "thilina-thesis-cloudtrail-logs"
  enable_log_file_validation = true
  is_multi_region_trail      = true
  is_organization_trail      = true
}
