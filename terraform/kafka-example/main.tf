module "kafka-cluster-security-group" {
  source = "../modules/kafka-cluster-security-group/"

  environment = var.environment
  vpc_name    = var.vpc_name
  ssh_ips    = var.ssh_ips
}

module "zookeeper" {
  source = "../modules/zookeeper/"

  environment       = var.environment
  vpc_name          = var.vpc_name
  availability_zone = "eu-north-1a"
  component_name    = "test"
  service           = "kafka"

  instance_type   = "t3.small"
  instance_count  = 3
  key_name        = var.master_key
}

# IPs allowed to reach Kafka
locals {
  allowed_ips = [
    "194.58.185.2/32"
  ]
}

module "kafka" {
  source = "../modules/kafka/"

  environment       = var.environment
  vpc_name          = var.vpc_name
  availability_zone = "eu-north-1a"
  zookeeper_quorum  = module.zookeeper.zookeeper_quorum
  component_name    = "test"

  instance_type   = "t3.medium"
  instance_count  = 3
  key_name        = var.master_key
  external_ips    = local.allowed_ips
  port_plain      = "9094"
  port_ssl        = "9092"
}
