package ClientRest;

use Carp;
use strict;
use warnings;
use Data::Dumper;

use version;

our $VERSION;
$VERSION = qv('0.0.1');

use JSON;
use REST::Client;

use constant {
    PORT_MIN   => 1,
    PORT_MAX   => 65535,
};

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
    my ($self) = @_;
    # Simple GET request for testing purposes
    $self->{_client}->GET('/snippets/');
    if (index($self->{_client}->responseContent(), "Can\'t connect to") != -1) {
	my @array = split /[http:\/\/]/, $self->{_host};
	@array = grep { $_ ne '' } @array;
	croak "Server is unavailable at IP: "
	    .$array[0]." and Port: "
	    .$array[1];
    }
    return decode_json $self->{_client}->responseContent();
}

# Module further implementation here

1;
