#!/bin/bash
# UBUNTU 16.04 WITH JENKINS 2.57

# Add repository for the Jenkins package
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian binary/" | sudo tee -a /etc/apt/sources.list.d/jenkins.list
sudo apt-get -y update

# Install Jenkins and start it
sudo apt-get -y install jenkins
sudo service jenkins start

# Install Apache server and configure to proxy from 80 to 8080
sudo apt-get -y install apache2
sudo service apache2 reload

# For building java maven projects
sudo apt-get -y install default-jdk
sudo apt-get -y install maven

# Install SMTP server for eMails inside Jenkins
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mailutils