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
  name                     = "s3_int"
  storage_provider          = "S3"
  enabled                  = true
  storage_aws_role_arn     = "arn:aws:iam::703671898489:role/json_test" # Replace with actual role ARN
  snowflake_storage_integration  = "s3://json-aptos/TRN.*"
  comment                  = "Integration with S3 for data loading and unloading"
}
