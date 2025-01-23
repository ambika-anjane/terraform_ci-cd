terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.87"
    }
  }
}

# AWS provider configuration for S3 access
provider "aws" {
  region  = "us-west-2"      # Replace with the AWS region you're working in
  profile = "default"        # Optional: Use specific AWS CLI profile
}

# S3 Bucket Integration for Snowflake
resource "snowflake_storage_integration" "s3_integration" {
  name                     = "s3_int"
  storage_provider          = "S3"
  enabled                  = true
  storage_aws_role_arn     = "arn:aws:iam::703671898489:role/json_test" # Replace with actual role ARN
  storage_allowed_locations  = ["s3://json-aptos/"]
  comment                  = "Integration with S3 for data loading and unloading"
}
