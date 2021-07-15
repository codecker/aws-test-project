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

# Encryption key for Cloudwatch log groups
resource "aws_kms_key" "kms_cloudwatch" {
  description              = "Encryption key for Cloud Watch log groups"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = true
  deletion_window_in_days  = 30

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "key-default-1",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::290484064745:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "logs.us-east-1.amazonaws.com"
      },
      "Action": [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ],
      "Resource": "*",
      "Condition": {
        "ArnLike": {
          "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:us-east-1:account-id:*"
        }
      }
    }    
  ]
}
  EOF

  tags = {
    name = "cloudwatch-kms-key"
    env  = "test"
  }
}

resource "aws_kms_alias" "kms_cloudwatch" {
  name          = "alias/cloudwatch_key"
  target_key_id = aws_kms_key.kms_cloudwatch.id
}
