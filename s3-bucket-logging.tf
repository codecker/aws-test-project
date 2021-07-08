# Define s3 bucket for logging
resource "aws_s3_bucket" "s3_logging" {
  bucket = "${random_string.random.id}-s3-logging"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.kms_s3.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  versioning {
    enabled = true
  }

  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 180
    }
  }

  tags = {
    name = "s3-logging"
    env  = "test"
  }
}

# Restrict s3 logging bucket from being publicly accessible
resource "aws_s3_bucket_public_access_block" "s3_logging_block_public" {
  bucket = aws_s3_bucket.s3_logging.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}