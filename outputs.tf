output "teamcity_web_ssh_command" {
  value = "${format("ssh -i ~/.ssh/teamcity admin@%s", "${module.ec2.teamcity_web_ip}")}"
}