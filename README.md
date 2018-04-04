# Perl5-MyClientRest-ClientRest
Client Implementation in combination with my Python Django Rest Framework Server that I running

To run the sample of code create a dir named MyClientRest, clone the repo into the new dir.

As a second step copy all content of repo in new dir (MyClientRest).

Sample of list of files in repo:

$ ls -la
total 56
drwxrwxr-x 3 tinyos tinyos  4096 Apr  4 19:23 .
drwxrwxr-x 3 tinyos tinyos  4096 Apr  4 19:23 ..
-rw-rw-r-- 1 tinyos tinyos  1578 Apr  4 19:23 ClientRest.pm
drwxrwxr-x 8 tinyos tinyos  4096 Apr  4 19:23 .git
-rw-rw-r-- 1 tinyos tinyos 35147 Apr  4 19:23 LICENSE
-rw-rw-r-- 1 tinyos tinyos   128 Apr  4 19:23 README.md

Sample of path (pwd in dir) /home/user/path/MyClientRest

Third step you can remove the empty clone repo (rm -rf Perl5-MyClientRest-ClientRest)

Forth step step out of the dir (cd..) sample of path (pwd in dir) /home/user/path

Finally create a sample perl file e.g. restClient.pl and place the sample of code bellow.

Sample of code:

#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use MyClientRest::ClientRest;

my $ip = '127.0.0.1';
my $port = '8000';
my $host = "http://$ip:$port";

# instatiate class
my $object = new ClientRest( $host,
			     $port,
			     $ip );

my $data = $object->getSnippets();
print Dumper $data;