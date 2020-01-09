#!/bin/bash
sudo mkdir -p /opt/teamcity
sudo mkdir -p /opt/teamcity/var/logs
sudo mkdir -p /opt/teamcity/lib/jdbc
sudo mkdir -p /opt/teamcity/config
sudo apt-get install -y apt-transport-https dirmngr
echo 'deb https://apt.dockerproject.org/repo debian-stretch main' | sudo tee --append /etc/apt/sources.list
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys F76221572C52609D
sudo apt-get update
sudo apt-get install tree
sudo apt-get install touch
sudo apt-get install -y docker-engine --allow-unauthenticated
sudo docker system prune -af
sudo docker rm $(docker ps -aq)
sudo docker pull jetbrains/teamcity-server
DEBIAN_FRONTEND=noninteractive sudo apt-get update -y
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y wget
wget https://jdbc.postgresql.org/download/postgresql-42.2.9.jre6.jar
sudo mv postgresql-42.2.9.jre6.jar /opt/teamcity/lib/jdbc/
sudo tee /opt/teamcity/config/database.properties <<EOF
connectionUrl=jdbc:postgresql://${db_url}:${db_port}/${db_name}
connectionProperties.user=${db_username}
connectionProperties.password=${db_password}
EOF
sudo sudo apt-get install -y postgresql
sudo docker run --rm -d --name teamcity-server-instance -v /opt/teamcity:/data/teamcity_server/datadir -v /opt/teamcity/var/logs:/opt/teamcity/logs -p 8111:8111 jetbrains/teamcity-server
