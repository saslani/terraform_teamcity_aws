resource "aws_key_pair" "upload_key" {
  key_name   = var.key_name
  public_key = file("${var.ssh_path}/${var.key_name}.pub")
}

resource "aws_instance" "teamcity" {
  ami                         = var.ami
  instance_type               = "t3.medium"
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_id
  user_data                   = data.template_file.teamcity_userdata.rendered
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  associate_public_ip_address = true
  depends_on                  = [aws_key_pair.upload_key]

  tags = {
    Name = "TeamCity"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "teamcity_userdata" {
  template = file("${path.module}/scripts/db_setup.sh")

  vars = {
    db_url      = var.db_url
    db_port     = var.db_port
    db_name     = var.db_name
    db_username = var.db_username
    db_password = var.db_password
  }
}

