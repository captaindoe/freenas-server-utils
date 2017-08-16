package Adylay::Model::Ip;

use strict;
use warnings;

use Mojo::UserAgent;

sub new { bless {}, shift }

sub get {
  my $self = shift;

  my $ua = Mojo::UserAgent->new;
  my $ipRes = $ua->get('http://ipecho.net/plain')->result;
  my $ip = $ipRes->body;
  my $res = $ua->get("http://ip-api.com/json/$ip")->result;
  
  return $res->json;
}

1;
