#!/usr/bin/env perl

use strict;

print "Status: 200\n";
print "Content-type: application/json\n\n";

my $curl = `which curl`;
if (@? == -1) {
  $curl = '/usr/local/bin/curl';
} else {
  chomp $curl;
}

my $ip = `$curl -s ipecho.net/plain`;
my $value = `$curl -s http://ip-api.com/json/$ip`;
print "$value\n";
