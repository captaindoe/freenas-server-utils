#!/bin/bash

username=$1
password=$2

working_dir=/opt/freenas-server-utils
openvpn_dir=/opt/openvpn
apache_www_dir=/usr/local/www/apache24
apache_cfg_dir=/usr/local/etc/apache24

pkg update \
  && pkg upgrade \
  && pkg install bash openvpn unzip curl apache24 vim \
  && pkg clean

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
cp $apache_cfg_dir/httpd.conf $apache_cfg_dir/httpd.conf.bak
cp $working_dir/apache2/conf/httpd.freebsd.conf $apache_cfg_dir/httpd.conf
cp -r $working_dir/apache2/public-html/* $apache_www_dir/data
cp -r $working_dir/apache2/cgi-bin/* $apache_www_dir/cgi-bin

# Enable openvpn as a service and set configuration
sysrc openvpn_enable=yes
sysrc openvpn_configfile=/opt/openvpn/...ovpn

# Enable apache web server as a service
sysrc apache24_enable=yes

# Start OpenVPN
service openvpn restart

# Start Apache Web Server
service apache24 restart

# Test IP Location
curl --silent http://ip-api.com/json/`curl --silent ipecho.net/plain ; echo` | json_pp


