#!/bin/bash
# UBUNTU 16.04 WITH JENKINS 2.58

# Add repository for the Jenkins package
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian binary/" | sudo tee -a /etc/apt/sources.list.d/jenkins.list
sudo apt-get -yqq update

# For building java maven projects
sudo apt-get -yqq install default-jdk
sudo apt-get -yqq install maven

# Install SMTP server for eMails inside Jenkins
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yqq mailutils

# Port forward 8080 requests to 80
sudo apt-get remove -yqq iptables-persistent
sudo iptables -I INPUT 1 -p tcp --dport 8080 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo sh -c "iptables-save > /etc/iptables.rules"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yqq iptables-persistent

# Install Jenkins and start it
sudo apt-get -yqq install jenkins

#  do something to unlock with /var/lib/jenkins/secrets/initialAdminPassword
sudo service jenkins start