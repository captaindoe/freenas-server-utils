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

1;
