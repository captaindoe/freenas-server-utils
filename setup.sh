#!/bin/bash

username=$1
password=$2

working_dir=/opt/freenas-server-utils
apache_dir=/usr/local/www/apache24
openvpn_dir=/opt/openvpn

pkg update \
  && pkg upgrade \
  && pkg install bash openvpn unzip curl apache24 vim

# Setup OpenVPN
mkdir -p $openvpn_dir 
cd $openvpn_dir
wget https://nordvpn.com/api/files/zip
unzip zip && rm -f zip

# Init credentials
cat > /opt/openvpn/credentials <<EOF
$username
$password
EOF

# Update all the openvpn configurations to point to the credentials file
sed -i '' "s|auth-user-pass|auth-user-pass /opt/openvpn/credentials|g" *

# Copy the scripts and html documents to the apache folders
cp -r $working_dir/apache2/cgi-bin/* $apache_home/cgi-bin/
cp -r $working_dir/public-html/* $apache_home/data/

# Enable openvpn as a service and set configuration
sysrc openvpn_enable=yes
sysrc openvpn_configfile=/opt/openvpn/...ovpn

# Enable apache web server as a service
sysrc apache24_enable=yes

# Start OpenVPN
/usr/local/etc/rc.d/openvpn start

# Test IP Location
curl --silent http://ip-api.com/json/`curl --silent ipecho.net/plain ; echo` | json_pp


