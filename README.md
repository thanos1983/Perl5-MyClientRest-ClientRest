# Perl5-MyClientRest-ClientRest
Client Implementation in combination with my Python Django Rest Framework Server that I running

To run the sample of code create a dir named MyClientRest, clone the repo into the new dir.

As a second step copy all content of repo in new dir (MyClientRest).

Sample of list of files in repo:

$ ls -la
total 56
drwxrwxr-x  3 user user  4096 Apr 11 20:13 .
drwxrwxr-x 14 user user  4096 Apr 11 20:13 ..
-rw-rw-r--  1 user user  2672 Apr 11 20:03 ClientRest.pm
-rw-rw-r--  1 user user     0 Apr  4 18:03 ClientRest.pm~
drwxrwxr-x  9 user user  4096 Apr 11 20:04 .git
-rw-rw-r--  1 user user 35147 Apr  4 19:20 LICENSE
-rw-rw-r--  1 user user  1190 Apr 11 20:13 README.md

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

my $host = "http://127.0.0.1:8000";

# my $host = "https://thanos-test.herokuapp.com/";

# instatiate class
my $object = new ClientRest( $host );

my $username = "admin";
my $password = "password123";
my $url = "/snippets/";
my $snippets = $object->getSnippets( $url, $username, $password );
print Dumper $snippets;

my $hashRef = { "title" => "Test Title",
		"code" => "print \"Test POST Request\"",
		"linenos" => "false",
		"language" => "perl",
		"character" => "\x{00AE}",
		"style" => "emacs" };

my %options = ( "url"      => $url,
		"hashRef"  => $hashRef,
		"username" => $username,
		"password" => $password );

# my $post = $object->postSnippets( %options );
# print Dumper $post;

my %optionsUpdate = ( "url"      => $url . '49/',
		      "hashRef"  => $hashRef,
		      "username" => $username,
		      "password" => $password );

my $put = $object->putSnippets( %optionsUpdate );
print Dumper $put;

my $file = 'Sample.txt';
my $upload = '/upload/';
my %optionsFile = ( "url"      => $upload,
		    "file"     => $file,
		    "username" => $username,
		    "password" => $password );

# my $postFile = $object->postSnippetsFile( %optionsFile );
# print Dumper $postFile;

__END__
my $urlDelete = "/snippets/38/";
my $delete = $object->deleteSnippets( $urlDelete, $username, $password);
print Dumper $delete;