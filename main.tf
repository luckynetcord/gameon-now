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

  schema {
    name             = "player_level"
    attribute_data_type = "String"
    required         = false
    mutable          = true
  }

  schema {
    name             = "membership_type"
    attribute_data_type = "String"
    required         = false
    mutable          = true
  }

  schema {
    name             = "membership_start_dt"
    attribute_data_type = "String"
    required         = false
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

  # Add MFA configuration
  mfa_configuration = "OPTIONAL"

  software_token_mfa_configuration {
    enabled = true
  }
  
  # Add account recovery settings
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  # Add email configuration
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  # Add verification message customization
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject = "Your GameOnNow verification code"
    email_message = "Your verification code is {####}"
  }

}


resource "aws_cognito_user_pool_client" "client" {
  name = "GameOnNowClient"
  user_pool_id = aws_cognito_user_pool.example.id
  
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  prevent_user_existence_errors = "ENABLED"
}