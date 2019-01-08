output "web_security_groups_id" {
  value = "${aws_security_group.teamcity_web_sg.id}"
}

output "rds_security_groups_id" {
  value = "${aws_security_group.rds_sg.id}"
}
