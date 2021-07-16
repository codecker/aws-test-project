# TODO: Automate CIDR blocks for Subnets

# Create all network components required - VPC, Subnets, Route tables

# Create Test VPC for project
resource "aws_vpc" "test_vpc" {
  cidr_block           = var.vpc_network_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Test VPC"
    env  = var.tag-env
  }
}

# Enable VPC flow logs
resource "aws_flow_log" "test_vpc_flow_logs" {
  log_destination      = aws_s3_bucket.s3_logging.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.test_vpc.id
}

# Create route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.test_vpc.id
  route  = []

  tags = {
    name = "public-route-table"
    env  = var.tag-env
  }
}

# Create route records 
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test_igw.id
}

# Attach public route table to public subnets
resource "aws_route_table_association" "public_route_assoc1" {
  subnet_id      = aws_subnet.test_public_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Attach public route table to public subnets
resource "aws_route_table_association" "public_route_assoc2" {
  subnet_id      = aws_subnet.test_public_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Get available subnets data for region
data "aws_availability_zones" "available_az" {}

resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id
}

resource "aws_subnet" "test_private_1" {
  cidr_block              = "10.10.0.0/26"
  vpc_id                  = aws_vpc.test_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_az.names[0]

  tags = {
    Name = "private-subnet-1"
    env  = var.tag-env
  }
}

resource "aws_subnet" "test_private_2" {
  cidr_block              = "10.10.0.64/26"
  vpc_id                  = aws_vpc.test_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_az.names[1]

  tags = {
    Name = "private-subnet-2"
    env  = var.tag-env
  }
}

resource "aws_subnet" "test_public_1" {
  cidr_block              = "10.10.0.128/26"
  vpc_id                  = aws_vpc.test_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_az.names[0]

  tags = {
    Name = "public-subnet-1"
    env  = var.tag-env
  }
}

resource "aws_subnet" "test_public_2" {
  cidr_block              = "10.10.0.192/28"
  vpc_id                  = aws_vpc.test_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_az.names[1]

  tags = {
    Name = "public-subnet-2"
    env  = var.tag-env
  }
}
