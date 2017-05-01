#!/bin/bash
# UBUNTU 16.04 WITH GitLab Community Edition

# Install Postfix and ssh server
sudo debconf-set-selections <<< "postfix postfix/mailname string localhost"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"

sudo apt-get install -y curl openssh-server ca-certificates postfix

# Install GitLab
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt-get install -y gitlab-ce
sudo gitlab-ctl reconfigure
sudo gitlab-rake gitlab:setup RAILS_ENV=production GITLAB_ROOT_PASSWORD=PASSWORD GITLAB_ROOT_EMAIL=howard.deiner@deinersoft.com force=yes
sudo gitlab-ctl reconfigure