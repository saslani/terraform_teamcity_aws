resource "aws_s3_bucket" "backup_bucket" {
  bucket = "${var.name}"
  acl    = "private"

  tags {
    Name = "${var.description}"
  }
}
