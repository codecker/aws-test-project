# TODO: 


resource "aws_cloudwatch_log_group" "test_nginx_access_log" {
  name = "/test/nginx-access-log"
  # kms_key_id        = aws_kms_key.kms_cloudwatch.id
  retention_in_days = 30

  tags = {
    name = "test_nginx_access_log"
    env  = "test"
  }
}

resource "aws_cloudwatch_log_group" "test_nginx_error_log" {
  name = "/test/nginx-error-log"
  # kms_key_id        = aws_kms_key.kms_cloudwatch.id
  retention_in_days = 30

  tags = {
    name = "test_nginx_error_log"
    env  = "test"
  }
}

resource "aws_cloudwatch_log_group" "test_init_log" {
  name = "/test/init-log"
  # kms_key_id        = aws_kms_key.kms_cloudwatch.id
  retention_in_days = 30

  tags = {
    name = "test_init_log"
    env  = "test"
  }
}
