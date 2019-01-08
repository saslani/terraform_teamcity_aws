output "database_address" {
  value = "${replace(aws_db_instance.database.endpoint, ":5432", "")}"
}

output "db_port" {
  value = "5432"
}
