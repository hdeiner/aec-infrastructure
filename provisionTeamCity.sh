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

# Port forward 8111 requests to 80
sudo apt-get remove -y iptables-persistent
sudo iptables -I INPUT 1 -p tcp --dport 8111 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8111
sudo iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 8111
sudo sh -c "iptables-save > /etc/iptables.rules"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent

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

# Start TeamCity up
sudo /etc/init.d/teamcity start

# Install SMTP server for eMails inside TeamCity
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mailutils

# Cleanup
rm -rf TeamCity-2017.1.1.tar.gz