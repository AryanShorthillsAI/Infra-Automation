variable "region" {}
variable "ami_id" {}
variable "instance_type" {}
variable "volume_size" {}
variable "key_name" {
  default = "github_actions_key"
}
