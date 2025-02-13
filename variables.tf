# Snowflake Account
variable "snowflake_account_name" {
  description = "The Snowflake account name (e.g., 'your_account.snowflakecomputing.com')"
  type        = string
}

variable "snowflake_organization_name" {
  description = "The Snowflake account name (e.g., 'your_account.snowflakecomputing.com')"
  type        = string
}
# Snowflake Username
variable "snowflake_user" {
  description = "The Snowflake username"
  type        = string
}

# Snowflake Password
variable "snowflake_password" {
  description = "The Snowflake password"
  type        = string
  sensitive   = true  # Mark as sensitive to prevent it from showing in logs
}

# Snowflake Warehouse
variable "snowflake_warehouse" {
  description = "The Snowflake warehouse to use"
  type        = string
}

# Snowflake Database
variable "snowflake_database" {
  description = "The Snowflake database to use"
  type        = string
}

# Snowflake Schema
variable "snowflake_schema" {
  description = "The Snowflake schema to use"
  type        = string
}

# Snowflake Role (Optional, if required)
variable "snowflake_role" {
  description = "The Snowflake role to use"
  type        = string
  default     = "PUBLIC"  # Default to PUBLIC if not provided
}

# Snowflake Warehouse Size (Optional)
variable "snowflake_warehouse_size" {
  description = "The size of the Snowflake warehouse (e.g., 'XSMALL', 'SMALL', 'MEDIUM', 'LARGE')"
  type        = string
  default     = "XSMALL"  # Default warehouse size if not provided
}


