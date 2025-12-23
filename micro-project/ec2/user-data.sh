#!/bin/bash
set -euxo pipefail

apt-get update -y

#install docker
curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
systemctl enable docker
systemctl start docker
usermod -aG docker $USER 

#enable ssm
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

#test, start nginx
docker run -p 3000:80 -d nginx
