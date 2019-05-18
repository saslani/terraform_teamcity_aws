resource "aws_s3_bucket" "backup_bucket" {
  bucket = "${var.name}"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name = "${var.description}"
  }
}
