#!/usr/bin/env perl

use strict;

print "Status: 200\n";
print "Content-type: application/json\n\n";

my $ip = `curl --silent ipecho.net/plain`;
my $value = `curl --silent http://ip-api.com/json/$ip`;
print "$value\n";
