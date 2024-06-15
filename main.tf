provider "aws" {
  region = "ca-central-1"  # Update with your desired AWS region
}

resource "aws_cognito_user_pool" "example" {
  name = "GameOnNowUserPool"

  # Configure username attributes
  username_attributes = ["email"]

  # Define user pool schema
  schema {
    name             = "email"
    attribute_data_type = "String"
    required         = true
    mutable          = false
  }

  schema {
    name             = "given_name"
    attribute_data_type = "String"
    required         = true
    mutable          = true
  }

  schema {
    name             = "family_name"
    attribute_data_type = "String"
    required         = true
    mutable          = true
  }

  schema {
    name             = "birthdate"
    attribute_data_type = "String"
    required         = true
    mutable          = true
  }

  schema {
    name             = "phone_number"
    attribute_data_type = "String"
    required         = true
    mutable          = true
  }

  schema {
    name             = "preferred_username"
    attribute_data_type = "String"
    required         = true
    mutable          = true
  }

  schema {
    name             = "gender"
    attribute_data_type = "String"
    required         = true
    mutable          = true
  }

  # Configure password policy
  password_policy {
    minimum_length = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  auto_verified_attributes = ["email"]
}
