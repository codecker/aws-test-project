# Create Test VPC for project
resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.10.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "Test VPC"
    env  = "test"
  }
}

resource "aws_flow_log" "test_vpc_flow_logs" {
  log_destination      = aws_s3_bucket.s3_logging.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.test_vpc.id
}