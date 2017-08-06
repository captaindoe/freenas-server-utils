#!/usr/local/bin/perl

use strict;

print "Status: 200\n";
print "Content-type: application/json\n\n";

my $curl;
if (`uname` == 'FreeBSD') {
  $curl = '/usr/local/bin/curl';
} else {
  $curl = `which curl`;
  chomp $curl;
}

my $ip = `$curl -s ipecho.net/plain`;
my $value = `$curl -s http://ip-api.com/json/$ip`;

print "$value\n";
