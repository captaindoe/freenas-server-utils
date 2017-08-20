package Adylay::Model::OpenVPN;

use strict;
use warnings;

use Mojo::JSON qw(from_json);
use Mojo::UserAgent;

sub new {
  my ($type, $config_location) = @_;

  my $self = bless {}, $type;

  $self->{openvpn_config_location} = $config_location;

  return $self;
}

sub get {
  my $self = shift;

  my @files = `ls $self->{openvpn_config_location}`;
  my $exec_status = $?;

  if ($exec_status != 0) {
    return undef;
  }

  chomp @files;
  return \@files;
}

sub update {
  my $self = shift;
  my $config = shift;

  my $cmd = "sysrc openvpn_configfile=$self->{openvpn_config_location}/$config && service openvpn restart";
  my $output = `$cmd`;
  # Return whether or not the command executed successfully
  return ($? == 0);
}

1;
