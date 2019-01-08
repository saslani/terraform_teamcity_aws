output "teamcity_web_ip" {
  value = "${aws_instance.teamcity.public_dns}"
}