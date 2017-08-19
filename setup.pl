#!/usr/bin/env perl

my ($username, $password) = @ARGV;

my $working_dir = '/opt/freenas-server-utils';
my $openvpn_dir = '/opt/openvpn';

qx 'pkg update \
    && pkg upgrade \
    && pkg install openvpn unzip curl git \
    && pkg clean';

# Checkout the repository
qx 'git clone https://github.com/lackerman/freenas-server-utils.git $working_dir';

# Setup the Mojolicious dependencies
qx 'cd $working_dir && curl -L https://cpanmin.us | perl - App::cpanminus && cpanm --installdeps . -M https://cpan.metacpan.org';

# Setup OpenVPN
qx 'mkdir -p $openvpn_dir \ 
    && cd $openvpn_dir \
    && curl https://nordvpn.com/api/files/zip -o nordvpn.zip \
    && unzip nordvpn.zip \
    && rm -f nordvpn.zip';

# Init credentials file
my $filename = '/opt/openvpn/credentials';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh "$username\n$password";
close $fh;

# Update all the openvpn configurations to point to the credentials file
qx "perl -pi -w -e 's|auth-user-pass|auth-user-pass /opt/openvpn/credentials|g;' *.ovpn";

# Enable openvpn as a service and set configuration
qx 'sysrc openvpn_enable=yes';

# This will be set by the webapp in future
#
# sysrc openvpn_configfile=/opt/openvpn/...ovpn

# Start OpenVPN
# service openvpn restart

# Test IP Location
# curl --silent http://ip-api.com/json/`curl --silent ipecho.net/plain ; echo` | json_pp
