resource "aws_db_instance" "database" {
  identifier                = "${var.instance_identifier}"
  final_snapshot_identifier = "${var.instance_identifier}"
  skip_final_snapshot       = true
  allocated_storage         = "60"
  storage_type              = "gp2"
  engine                    = "postgres"
  instance_class            = "db.t2.medium"
  name                      = "${var.db_name}"
  username                  = "${var.db_username}"
  password                  = "${var.db_password}"
  port                      = 5432
  publicly_accessible       = false
  vpc_security_group_ids    = ["${var.vpc_security_group_ids}"]
  db_subnet_group_name      = "${var.db_subnet_group_name}"
  multi_az                  = true
  backup_retention_period   = 7
  backup_window             = "08:17-08:47"
  maintenance_window        = "sat:09:30-sat:22:00"

  tags {
    Name = "TeamCity RDS"
  }
}
