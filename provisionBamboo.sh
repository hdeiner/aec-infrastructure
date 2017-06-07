#!/bin/bash
# UBUNTU 16.04 WITH BAMBOO

# For building java maven projects
sudo apt-get -y update
sudo apt-get -y install default-jdk
sudo apt-get -y install maven

# Install SMTP server for eMails inside Bamboo
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mailutils

# Port forward 8085 requests to 80
sudo apt-get remove -y iptables-persistent
sudo iptables -I INPUT 1 -p tcp --dport 8111 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8085
sudo iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 8085
sudo sh -c "iptables-save > /etc/iptables.rules"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent

# Download and install Bamboo
wget http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-6.0.2.tar.gz
sudo tar -zxvf /home/ubuntu/atlassian-bamboo-6.0.2.tar.gz  -C /opt/
sudo ln -s /opt/atlassian-bamboo-6.0.2/ /opt/atlassian-bamboo-6.0.2/current
sudo echo "bamboo.home=/home/ubuntu" | sudo tee -a /opt/atlassian-bamboo-6.0.2/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
sudo bash -c 'cat <<EOF >> /etc/init.d/bamboo
#!/bin/sh
set -e
### BEGIN INIT INFO
# Provides: bamboo
# Required-Start: $local_fs $remote_fs $network $time
# Required-Stop: $local_fs $remote_fs $network $time
# Should-Start: $syslog
# Should-Stop: $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Atlassian Bamboo Server
### END INIT INFO
# INIT Script
######################################

# Define some variables
# Name of app ( bamboo, Confluence, etc )
APP=bamboo
# Name of the user to run as
USER=ubuntu
# Location of application bin directory
BASE=/opt/atlassian-bamboo-6.0.2/

case "\$1" in
  # Start command
  start)
    echo "Starting \$APP"
    /bin/su - \$USER -c "export BAMBOO_HOME=\${BAMBOO_HOME}; \$BASE/bin/startup.sh"
    ;;
  # Stop command
  stop)
    echo "Stopping \$APP"
    /bin/su - \$USER -c "\$BASE/bin/shutdown.sh"
    echo "\$APP stopped successfully"
    ;;
   # Restart command
   restart)
        \$0 stop
        sleep 5
        \$0 start
         ;;
  *)
    echo "Usage: /etc/init.d/\$APP {start|restart|stop}"
    exit 1
    ;;
esac
EOF'
sudo chmod a+x /etc/init.d/bamboo
sudo update-rc.d bamboo defaults
sudo chown ubuntu -R /opt/atlassian-bamboo-6.0.2/
sudo /etc/init.d/bamboo start
sleep 10
wget http://localhost:8085
sleep 20
sudo /etc/init.d/bamboo stop
sleep 5
# Fix server id to allow license to be applied
sudo sed -i -E 's/[A-Z0-9]+\-[A-Z0-9]+\-[A-Z0-9]+\-[A-Z0-9]+/BTLC-10KO-ISOI-PQ53/' bamboo.cfg.xml
sudo /etc/init.d/bamboo start

# Cleanup
sudo rm -rf atlassian-bamboo-6.0.2.tar.gz index.html