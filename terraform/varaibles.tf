variable "aws_region" {
  type        = string
  description = "The name of the AWS region"
  default = "ap-northeast-1"
}

variable "profile" {
  type        = string
  description = "The name of the AWS profile"
  default = "terraform-cloud-user"
}

# backend server variables
variable "instance_config" {
  type = object({
    backend_instance_name = string
    backend_instance_type = string
    backend_environment   = string
  })
  description = "Instance configuration"

  default = {
   backend_instance_name    = "react-backend-server"
   backend_instance_type = "t2.micro"
   backend_environment = "staging"
 }

  validation {
    condition     = length(var.instance_config.backend_instance_name) > 5 && length(var.instance_config.backend_instance_name) < 20
    error_message = "The character length of the backend instance name should be between 5 and 25"
  }

  validation {
    condition     = contains(["t2.micro", "t3.micro", "t2.medium", "t3.medium"], var.instance_config.backend_instance_type)
    error_message = "The allowed backend instance types are t2.micro and t3.micro and t2.medium and t3.medium"
  }

  validation {
    condition     = contains(["dev", "staging", "prod"], var.instance_config.backend_environment)
    error_message = "The allowed backend environments are dev and staging and prod"
  }
}

# backend server variables
variable "instance_config" {
  type = object({
    backend_instance_name = string
    backend_instance_type = string
    backend_environment   = string
  })
  description = "Backend Instance configuration"

  default = {
   backend_instance_name    = "express-backend-server"
   backend_instance_type = "t2.micro"
   backend_environment = "staging"
 }

  validation {
    condition     = length(var.instance_config.backend_instance_name) > 5 && length(var.instance_config.backend_instance_name) < 20
    error_message = "The character length of the backend instance name should be between 5 and 25"
  }

  validation {
    condition     = contains(["t2.micro", "t3.micro", "t2.medium", "t3.medium"], var.instance_config.backend_instance_type)
    error_message = "The allowed backend instance types are t2.micro and t3.micro and t2.medium and t3.medium"
  }

  validation {
    condition     = contains(["dev", "staging", "prod"], var.instance_config.backend_environment)
    error_message = "The allowed backend environments are dev and staging and prod"
  }
}


variable "create_instances" {
  type        = bool
  description = "Whether to create instances or not"
  default     = true
}

variable "instance_count" {
  type        = number
  description = "Number of instances to create"
  validation {
    condition     = var.instance_count > 0 && var.instance_count < 10
    error_message = "The instance count should be between 1 and 10"
  }
}