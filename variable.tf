variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "key_name" {}
variable "public_key" {}
variable "region" {
  default = "ap-southeast-1"
}
variable "ssh_key_pair" {
  type        = string
  description = "SSH key pair to be provisioned on the instance"
  default     = null
}
variable "db_username" {}
variable "db_password" {}