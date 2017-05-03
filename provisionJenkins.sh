#!/bin/bash
# UBUNTU 16.04 WITH JENKINS 2.58

# Add repository for the Jenkins package
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian binary/" | sudo tee -a /etc/apt/sources.list.d/jenkins.list
sudo apt-get -y update

# Install Jenkins and start it
sudo apt-get -y install jenkins
#  do something to unlock with /var/lib/jenkins/secrets/initialAdminPassword
sudo service jenkins start

# For building java maven projects
sudo apt-get -y install default-jdk
sudo apt-get -y install maven

# Install SMTP server for eMails inside Jenkins
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mailutils

# Make Jenkins run on port 80
# Port forward requests from outside
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080
# Port forward requests from localhost
sudo iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 8080
sudo sh -c "iptables-save > /etc/iptables.rules"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent