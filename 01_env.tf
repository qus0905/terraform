provider "aws" {
  region="ap-northeast-2"
}
variable "www_domain_name" {
  default = "www.jybyun.xyz"
}
variable "root_domain_name" {
  default="jybyun.xyz"
}