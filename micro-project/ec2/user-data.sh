 #!/bin/bash
set -e

sudo apt-get update

#install docker
curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER 

#enable ssm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

#test, start nginx
sudo docker run -p 3000:80 -d nginx
