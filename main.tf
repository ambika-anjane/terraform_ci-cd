terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.87"
    }
  }
}



# S3 Bucket Integration for Snowflake
resource "snowflake_storage_integration" "s3_integration" {
  name                     = "S3_STORAGE_INTEGRATION"
  storage_provider          = "S3"
  enabled                  = true
  storage_aws_role_arn     = "arn:aws:iam::123456789012:role/SnowflakeRole" # Replace with actual role ARN
  external_stage_location  = "s3://your-bucket-name/path/" # Replace with your actual S3 bucket and path
  comment                  = "Integration with S3 for data loading and unloading"
}
