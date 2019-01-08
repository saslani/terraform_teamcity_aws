output "db_subnet_group_name" {
  value = "${aws_db_subnet_group.rds.name}"
}

output "private_subnet" {
  value = ["${aws_subnet.private.*.id}"]
}

output "public_subnet" {
  value = "${aws_subnet.public.id}"
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
