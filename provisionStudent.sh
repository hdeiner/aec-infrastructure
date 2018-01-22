#!/bin/bash
# UBUNTU 16.04 WITH GUACAMOLE 0.9.12, TOMCAT8, AND TIGHTVNC

#Install Stuff
sudo apt-get -yqq update
sudo apt-get -yqq install build-essential libcairo2-dev libjpeg-turbo8-dev libpng12-dev libossp-uuid-dev
sudo apt-get -yqq install libavcodec-dev libavutil-dev libswscale-dev libfreerdp-dev libpango1.0-dev
sudo apt-get -yqq install libssh2-1-dev libtelnet-dev libvncserver-dev libpulse-dev libssl-dev
sudo apt-get -yqq install libvorbis-dev libwebp-dev tomcat8 freerdp ghostscript jq wget curl

# Add GUACAMOLE_HOME to Tomcat8 ENV
sudo chmod +w /etc/default/tomcat8
sudo echo "" >> /etc/default/tomcat8
sudo echo "# GUACAMOLE EVN VARIABLE" >> /etc/default/tomcat8
sudo echo "GUACAMOLE_HOME=/etc/guacamole" >> /etc/default/tomcat8

# Get your Preferred Mirror for download from Apache using jq
SERVER=$(curl -s 'https://www.apache.org/dyn/closer.cgi?as_json=1' | jq --raw-output '.preferred|rtrimstr("/")')

# Download Guacamole Files from Preferred Mirror
wget $SERVER/guacamole/0.9.14/source/guacamole-server-0.9.14.tar.gz
wget $SERVER/guacamole/0.9.14/binary/guacamole-0.9.14.war

#Extract Guacamole
tar -xzf guacamole-server-0.9.14.tar.gz

# MAKE DIRECTORIES
sudo mkdir /etc/guacamole
sudo mkdir /etc/guacamole/lib
sudo mkdir /etc/guacamole/extensions

# configure guacamole server
sudo bash -c 'cat <<EOF >> /etc/guacamole/guacamole.properties
guacd-hostname:     localhost
guacd-port:         4822
user-mapping:       /etc/guacamole/user-mapping.xml
auth-provider:      net.sourceforge.guacamole.net.basic.BasicFileAuthenticationProvider
basic-user-mapping: /etc/guacamole/user-mapping.xml
EOF'

#sudo ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat8/.guacamole/

sudo bash -c 'cat <<EOF >> /etc/guacamole/user-mapping.xml
<user-mapping>
    <authorize username="USERNAME" password="PASSWORD">
        <connection name="Agile Engineering Workshop">
            <protocol>vnc</protocol>
            <param name="hostname">localhost</param>
            <param name="port">5901</param>
            <param name="password">VNCPASS</param>
        </connection>
    </authorize>
</user-mapping>
EOF'

# Install GUACD
cd guacamole-server-0.9.14
./configure --with-init-dir=/etc/init.d
make
sudo make install
sudo ldconfig
sudo systemctl enable guacd
cd ..

# Move files to correct locations
sudo mv guacamole-0.9.14.war /etc/guacamole/guacamole.war
sudo ln -s /etc/guacamole/guacamole.war /var/lib/tomcat8/webapps/
sudo rm -rf /var/lib/tomcat8/webapps/ROOT
sudo mv /var/lib/tomcat8/webapps/guacamole.war /var/lib/tomcat8/webapps/ROOT.war
sudo ln -s /usr/local/lib/freerdp/* /usr/lib/x86_64-linux-gnu/freerdp/.

sudo rm -rf /usr/share/tomcat8/.guacamole
sudo ln -s /etc/guacamole /usr/share/tomcat8/.guacamole

# Restart Tomcat Service
sudo service tomcat8 restart

# Startup guacamole
/usr/local/sbin/guacd

# Install VNC server
sudo apt-get -yqq install tightvncserver

# Install xfece4 (until ubuntu-desktop works)
sudo apt-get -yqq install xfce4 xfce4-goodies
sudo apt-get -yqq install gnome-icon-theme-full tango-icon-theme
sudo apt-get -yqq install chromium-browser

# Install MATE desktop environment (until ubuntu-desktop works)
sudo apt-get -yqq install mate-desktop-environment

# Install ubuntu-desktop
# sudo apt-get -yqq install ubuntu-desktop gnome-panel gnome-settings-daemon

# Make up a VNC password file
mkdir /home/ubuntu/.vnc
echo "VNCPASS" | vncpasswd -f > /home/ubuntu/.vnc/passwd
chmod 0600 /home/ubuntu/.vnc/passwd

# Configure VNCSERVER to bring up desktop
bash -c 'cat <<EOF >> /home/ubuntu/.vnc/xstartup
#!/bin/sh
#xrdb $HOME/.Xresources
# Fix to make GNOME work
export XKL_XMODMAP_DISABLE=1
#startxfce4 &
mate-session &
DISPLAY=:1 xfce4-terminal &
intellij &
EOF'

chmod +x /home/ubuntu/.vnc/xstartup

# Configure vncserver to start on reboot
sudo bash -c "cat <<EOF >> /etc/init.d/tightvncserver
#!/bin/sh
# /etc/init.d/tightvncserver
  case "\\\$1" in
  start)
    sudo -u ubuntu /usr/bin/tightvncserver :1 -geometry 1280x768 -depth 16
    echo 'Starting TightVNC server'
    ;;
  stop)
    pkill Xtightvnc
    echo 'Tightvncserver stopped'
    ;;
  *)
    echo 'Usage: /etc/init.d/tightvncserver {start|stop}'
    exit 1
    ;;
esac
exit 0
EOF"

sudo chmod 755 /etc/init.d/tightvncserver
sudo update-rc.d tightvncserver defaults

# Install Eclipse
sudo apt-get -yqq install eclipse

# Install IntelliJ
sudo apt-get -yqq install default-jdk
wget https://download.jetbrains.com/idea/ideaIC-2017.3.3.tar.gz
sudo tar -xf ideaIC-2017.3.3.tar.gz -C /opt/
sudo ln -s /opt/idea*/bin/idea.sh /usr/local/sbin/intellij
sudo bash -c 'cat <<EOF >> /usr/share/applications/intellij.desktop
[Desktop Entry]
Version=IntelliJ IDEA 2017.3.3
Type=Application
Terminal=false
Icon[en-US]=/opt/idea-*/bin/idea.png
Name[en-US]=IntelliJ
Exec=/opt/idea-*/bin/idea.sh
Name=IntelliJ
Icon=/opt/idea-*/bin/idea.png
Categories=Development;IDE;Java;
EOF'
sudo chmod 644 /usr/share/applications/intellij.desktop
sudo chown root:root /usr/share/applications/intellij.desktop

# Preset the ubuntu user
cd /tmp
wget https://s3.amazonaws.com/howarddeiner/provisionUbuntuUser.tar
tar --exclude='.ssh' -xf provisionUbuntuUser.tar -C /

# Port forward 8080 requests to 80
sudo apt-get remove -yqq iptables-persistent
sudo iptables -I INPUT 1 -p tcp --dport 8080 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080
sudo iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 8080
sudo sh -c "iptables-save > /etc/iptables.rules"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yqq iptables-persistent

# Cleanup
rm -rf /home/ubuntu/guacamole-server-0.9.12-incubating.tar.gz
rm -rf /home/ubuntu/guacamole-server-0.9.12-incubating
rm -rf /home/ubuntu/ideaIC-2017.1.4.tar.gz
rm -rf /tmp/provisionUbuntuUser.tar

cd ~
git clone https://github.com/jamesbyars/aec-calculator.git