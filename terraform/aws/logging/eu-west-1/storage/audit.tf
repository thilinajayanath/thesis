resource "aws_s3_bucket" "s3_audit_logs" {
  bucket = "thilina-thesis-audit-logs"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Environment = "Logging"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_audit_logs" {
  bucket = aws_s3_bucket.s3_audit_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
