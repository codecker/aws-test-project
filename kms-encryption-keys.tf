# Encryption key for S3
resource "aws_kms_key" "kms_s3" {
  description              = "Encryption key for all S3 buckets"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = true
  deletion_window_in_days  = 30

  tags = {
    name = "s3-kms-key"
    env  = "test"
  }
}

resource "aws_kms_alias" "kms_s3" {
  name          = "alias/s3_key"
  target_key_id = aws_kms_key.kms_s3.id
}


# Encryption key for EBS volumes
resource "aws_kms_key" "kms_ebs" {
  description              = "Encryption key for all EBS volumes"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = true
  deletion_window_in_days  = 30

  tags = {
    name = "ebs-kms-key"
    env  = "test"
  }
}

resource "aws_kms_alias" "kms_ebs" {
  name          = "alias/ebs_key"
  target_key_id = aws_kms_key.kms_ebs.id
}