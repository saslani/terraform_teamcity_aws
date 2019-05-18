provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  version    = "2.11.0"
  region     = "${var.region}"
}

data "aws_availability_zones" "zones" {}

module "vpc" {
  source             = "vpc"
  availability_zones = ["${data.aws_availability_zones.zones.names}"]
  length             = 2
}

module "sg" {
  source = "sg"
  vpc_id = "${module.vpc.vpc_id}"
}

module "rds" {
  source                 = "rds"
  db_name                = "${var.db_name}"
  db_password            = "${var.db_password}"
  db_username            = "${var.db_username}"
  db_subnet_group_name   = "${module.vpc.db_subnet_group_name}"
  dns_name               = "pg"
  instance_identifier    = "${var.db_name}"
  vpc_id                 = "${module.vpc.vpc_id}"
  private_subnet_id      = ["${module.vpc.private_subnet}"]
  service_name           = "TeamCity"
  vpc_security_group_ids = "${module.sg.rds_security_groups_id}"
}

module "backup_bucket" {
  source      = "s3"
  name        = "${var.unique_s3_name}"
  description = "TeamCity Backups"
}

module "ec2" {
  source                 = "ec2"
  ami                    = "${var.debian_ami}"
  db_username            = "${var.db_username}"
  db_password            = "${var.db_password}"
  db_name                = "${var.db_name}"
  db_port                = "${module.rds.db_port}"
  db_url                 = "${module.rds.database_address}"
  key_name               = "${var.key_name}"
  public_subnet_id       = "${module.vpc.public_subnet}"
  ssh_path               = "${var.ssh_path}"
  vpc_security_group_ids = "${module.sg.web_security_groups_id}"
}
