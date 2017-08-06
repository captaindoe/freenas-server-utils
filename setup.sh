#!/bin/bash

username=$1
password=$2

pkg update \
  && pkg upgrade \
  && pkg install bash openvpn unzip curl apache24 vim

# Setup OpenVPN
mkdir -p /opt/openvpn
cd /opt/openvpn
wget https://nordvpn.com/api/files/zip
unzip zip
rm -f zip
touch 
cat > /opt/openvpn/credentials <<EOF
$username
$password
EOF

sed -i '' "s|auth-user-pass|auth-user-pass /opt/openvpn/credentials|g" *

# Copy the scripts and html documents to the apache folders
apache_home=/usr/local/www/apache24
cp -r cgi-bin/* $apache_home/cgi-bin/
cp -r public-html/* $apache_home/data/

# Enable openvpn as a service and set configuration
sysrc openvpn_enable=yes
sysrc openvpn_configfile=/opt/openvpn/...ovpn

# Enable apache web server as a service
sysrc apache24_enable=yes

# Start OpenVPN
/usr/local/etc/rc.d/openvpn start

# Test IP Location
curl --silent http://ip-api.com/json/`curl --silent ipecho.net/plain ; echo` | json_pp


