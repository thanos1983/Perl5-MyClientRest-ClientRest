package ClientRest;

use JSON;
use Carp;
use strict;
use warnings;
use MIME::Base64;
use Data::Dumper;

use version;

our $VERSION;
$VERSION = qv('0.0.1');

use REST::Client;

sub new {
    my $class = shift;
    my $self = {
        _host => shift,
    };
    _parameterValidation($self);
    # instatiate Rest::Client and create constructor
    my $client = REST::Client->new({
	host    => $self->{_host},
	timeout => 10, });
    $self->{_client} = $client;
    bless $self, $class;
    return $self;
}

sub _parameterValidation {
    my( $self ) = @_;
    croak "Invalid host syntax: sample 'http://<host>:<port>' "
	unless ( $self->{_host} =~ /^http:\/\/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\:\d{1,5}$/ );
}

sub getSnippets {
    my ( $self, $url, $username, $password ) = @_;
    # Simple GET request for testing purposes
    if (defined $username && defined $password) {
	my $headers = { Accept => 'application/json',
			Authorization => 'Basic ' . encode_base64($username . ':' . $password) };
	$self->{_client}->GET( $url, $headers );
    }
    else {
	$self->{_client}->GET( $url );
    }
    if (index($self->{_client}->responseContent(), "Can\'t connect to") != -1) {
	my @array = split /[http:\/\/]/, $self->{_host};
	@array = grep { $_ ne '' } @array;
	croak "Server is unavailable at IP: "
	    .$array[0]." and Port: "
	    .$array[1];
    }
    return decode_json $self->{_client}->responseContent();
}

sub postSnippets {
    my ( $self, %options ) = @_;
    my $headers = { "Content-type" => 'application/json; charset=UTF-8',
		    "Authorization" => 'Basic ' .
			encode_base64($options{username} . ':' . $options{password}) };
    $self->{_client}->POST( $options{url},
			    encode_json($options{hashRef}),
			    $headers );
    return decode_json $self->{_client}->responseContent();
}

sub postSnippetsFile {
    my ( $self, %options ) = @_;
    my $headers = { "Content-type" => 'multipart/form-data',
		    # "Content" => [ 'file' => [$options{file}]],
		    "Authorization" => 'Basic '.
			encode_base64($options{username} . ':' . $options{password}), };
    $self->{_client}->POST( $options{url},
			    encode_json({file => $options{file}}),
			    $headers );
    return $self->{_client}->responseContent();
}

sub deleteSnippets {
    my ( $self, $url, $username, $password ) = @_;
    my $headers = { Accept => 'application/json',
		    Authorization => 'Basic ' . encode_base64($username . ':' . $password) };
    # Simple GET request for testing purposes
    $self->{_client}->DELETE($url, $headers);
    if ($self->{_client}->responseCode() == '204') {
	return "DELETE" . $url . " OK " . $self->{_client}->responseCode();
    }
    return $url . " " . $self->{_client}->responseContent();
}

1;
