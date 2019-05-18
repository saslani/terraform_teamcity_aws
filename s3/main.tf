resource "aws_s3_bucket" "backup_bucket" {
  bucket = "${var.name}"
  acl    = "private"
  
  versioning {
    enabled = true
  }

	server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name = "TeamCity Backups"
  }
}

resource "aws_s3_bucket_public_access_block" "private_bucket" {
  bucket = "${aws_s3_bucket.backup_bucket.id}"

  block_public_acls   = true
  block_public_policy = true
}
