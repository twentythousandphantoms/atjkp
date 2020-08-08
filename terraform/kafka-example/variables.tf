variable "environment" {
  type = string
  default = "test"
}

variable "vpc_name" {
  type = string
  default = "default"
}

variable "master_key" {
  type = string
}

variable "ssh_ips" {
  default = ["194.58.184.0/21"]
}