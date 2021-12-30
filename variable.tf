variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "key_name" {}
variable "public_key" {}
variable "region" {
  default = "ap-southeast-1"
}
variable "network_address_space" {
  default = "10.0.0.0/16"
}
variable "subnet_count" {
  default = 3
}
variable "instance_count" {
  default = 1
}
variable "common_tags" {
  default = {}
}
variable "environment_tag" {}