variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret key"
}

variable "db_name" {
  default = "teamcity"
}

variable "db_password" {
  type = string
}

variable "db_username" {
  default = "teamcityuser"
}

variable "debian_ami" {
  default = "ami-05829248ffee66250"
}

variable "key_name" {
  default = "teamcity"
}

variable "region" {
  default = "us-east-2"
}

variable "ssh_path" {
  default = "~/.ssh"
}

variable "unique_s3_name" {
  type = string
}

