locals {
  env_name = "dev"

  common_tags = {
    Environment = var.environment_tag
  }
}