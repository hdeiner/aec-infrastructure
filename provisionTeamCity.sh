#!/bin/bash
# UBUNTU 16.04 WITH TEAMCITY

# For building java maven projects
sudo apt-get -y update
sudo apt-get -y install default-jdk
sudo apt-get -y install maven

# Download and install TeamCity
wget https://download.jetbrains.com/teamcity/TeamCity-2017.1.1.tar.gz
sudo tar -xvf TeamCity-2017.1.1.tar.gz -C /opt/
sudo chown -R ubuntu /opt/TeamCity

# Configure autostart and stop scripts
sudo bash -c "cat <<EOF >> /etc/init.d/teamcity
#!/bin/sh
 # /etc/init.d/teamcity -  startup script for teamcity
 export TEAMCITY_DATA_PATH="/opt/TeamCity/.BuildServer"

 case \\\$1 in
 start)
  start-stop-daemon --start  -c ubuntu --exec /opt/TeamCity/bin/runAll.sh start
 ;;

 stop)
  start-stop-daemon --start -c ubuntu --exec  /opt/TeamCity/bin/runAll.sh stop
 ;;

 esac

 exit 0
EOF"

sudo chmod +x /etc/init.d/teamcity
sudo update-rc.d teamcity defaults

# Start it up
sudo /etc/init.d/teamcity start

# Install SMTP server for eMails inside TeamCity
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mailutils

# Make TeamCity run on port 80
# Port forward requests from outside
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8111
# Port forward requests from localhost
sudo iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 8111
sudo sh -c "iptables-save > /etc/iptables.rules"

# Cleanup
rm -rf TeamCity-2017.1.1.tar.gz