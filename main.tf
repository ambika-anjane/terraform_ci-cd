terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.87"
    }
  }
}

provider "snowflake" {
  organization_name = "QSHODUU"
  account_name      = "GJ72580"
  user              = "AMBIKA"
  password          = "Ambika#2025"
  role              = "ACCOUNTADMIN" # Optional
  warehouse         = "COMPUTE_WH"
}

# Create the Database 'dev_raw'
resource "snowflake_database" "dev" {
  name = "DEV_AMBIKA"
}

# Create the Schema 'dev_test' within the 'dev_raw' database
resource "snowflake_schema" "devtest" {
  name      = "DEV_SCHEMA"
  database  = snowflake_database.dev.name
}



# Create the Storage Integration for S3
resource "snowflake_storage_integration" "s3_integration" {
  name               = "STORAGE_S3"
  type               = "EXTERNAL_STAGE"
  storage_provider   = "S3"
  storage_aws_role_arn = "arn:aws:iam::703671898489:role/json_test" # Replace with your IAM role ARN
  enabled            = true
  storage_allowed_locations = ["*"]
}

# Create the Storage Integration for S3
resource "snowflake_stage" "example_stage_with_integration" {
  name               = "S3_EXTERNAL"
  url                = "s3://json-aptos/TRN"  # Your S3 bucket URL
  database           = snowflake_database.dev.name
  schema             = snowflake_schema.devtest.name
  storage_integration = snowflake_storage_integration.s3_integration.name
}




# Create the Table 'raw_transactions' within the 'dev_test' schema
# Create the Table 'raw_transactions' within the 'dev_test' schema
resource "snowflake_table" "raw_transactions" {
  name     = "RAW_TRANSACTIONS"
  database = snowflake_database.dev.name
  schema   = snowflake_schema.devtest.name

  
  column {
    name = "name"
    type = "STRING"
  }
  column {
    name = "age"
    type = "NUMBER"
  }
  column {
    name = "city"
    type = "STRING"
  }
  
  
}

# Create the Pipe for auto-ingestion from S3 into the table
resource "snowflake_pipe" "pipe" {
  database = snowflake_database.dev.name
  schema   = snowflake_schema.devtest.name
  name     = "MY_PIPE"

  comment = "A pipe"

  # Use fully qualified names for the table and stage to avoid session context issues
  copy_statement  = "COPY INTO  DEV_AMBIKA.DEV_SCHEMA.RAW_TRANSACTIONS FROM @DEV_AMBIKA.DEV_SCHEMA.S3_EXTERNAL FILE_FORMAT = (TYPE = 'JSON')MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE PATTERN = '.json$'"
  auto_ingest = true
  # Ensure the table is created before the pipe
  depends_on = [snowflake_table.raw_transactions,
  snowflake_storage_integration.s3_integration]
}


  
output "sqs_4_snowpipe" {
  value = snowflake_pipe.pipe.notification_channel
}






