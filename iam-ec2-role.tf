# Create 
resource "aws_iam_role" "test_ec2_role" {
  name               = "ec2_role"
  description        = "Role created to allow sending of logs and metrics to CloudWatch"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    env = "test"
  }
}

resource "aws_iam_policy" "cloudwatch_log_policy" {
  name = "cloudwatch_log_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
    ],
      "Resource": [
        "*"
    ]
  }
]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_cloudwatch_log_attach" {
  role       = aws_iam_role.test_ec2_role.name
  policy_arn = aws_iam_policy.cloudwatch_log_policy.arn
}

resource "aws_iam_instance_profile" "test_web" {
  name = "test_web"
  role = aws_iam_role.test_ec2_role.name
}
