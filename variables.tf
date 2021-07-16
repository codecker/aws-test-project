# TODO: Split out variables to tfvars file to support multiple workspaces

# Network CIDR block
variable "vpc_network_cidr" {
  default = "10.10.0.0/24"
}

# Define the default region
variable "aws-region" {
  default = "us-east-1"
}

# Define common tags
variable "tag-env" {
  default = "test"
}
