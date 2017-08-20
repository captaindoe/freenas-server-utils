#!/usr/bin/env perl

my $os = `uname`;
chomp $os;

sub execute {
  my $task = shift;
  my $script = shift;

  print "Starting task: $task...";
  my $output = qx "$script";
  if ($exitCode == $?) {
    print "Completed\n";
  } else {
    print "Failed\n";
    print "$output\n";
  }
}

sub isFreeBsd() {
  return $os eq 'FreeBSD';
}

my ($username, $password) = @ARGV;

my $working_dir = '/opt/freenas-server-utils';
my $openvpn_dir = '/opt/openvpn';

if (isFreeBsd()) {
  execute 'Installing dependencies', 'pkg update \
  && pkg upgrade -y \
  && pkg install -y git openvpn unzip \
  && pkg clean --yes';
}

if (!(-e $working_dir and -d $working_dir)) {
  execute 'Get Project Source', 'mkdir -p /opt \
  && cd /opt \
  && git clone https://github.com/lackerman/freenas-server-utils.git \
  && cd freenas-server-utils';
}

execute 'Install Cpanminus', 'curl -sL https://cpanmin.us | perl - App::cpanminus;';
execute 'Setup the Mojolicious dependencies', "cd $working_dir && \\
cpanm --installdeps . -M https://cpan.metacpan.org";

execute 'Setup OpenVPN', "mkdir -p $openvpn_dir \\
&& cd $openvpn_dir \\
&& curl -s https://nordvpn.com/api/files/zip -o nordvpn.zip \\
&& unzip -qo nordvpn.zip \\
&& rm -f nordvpn.zip";

execute 'Updating Config', "cd $openvpn_dir \\
&& perl -pi -w -e 's|auth-user-pass|auth-user-pass /opt/openvpn/credentials|g;' *.ovpn";

# Init credentials file
my $filename = '/opt/openvpn/credentials';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh "$username\n$password\n";
close $fh;

execute('Enable openvpn as a service', 'sysrc openvpn_enable=yes') unless isFreeBsd();

# This will be set by the webapp in future
#
# sysrc openvpn_configfile=/opt/openvpn/...ovpn

# Start OpenVPN
# service openvpn restart

# Test IP Location
# curl --silent http://ip-api.com/json/`curl --silent ipecho.net/plain ; echo` | json_pp
