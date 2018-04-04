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
        _port => shift,
	_ip   => shift,
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
    use Regexp::Common qw/ net number /;

    # these become available:
    # $RE{net}{IPv6}
    # $RE{net}{IPv4}

    croak "Invalid IP: ".$self->{_ip}.""
	unless ( $self->{_ip} =~ m/$RE{net}{IPv4}/ );

    croak "Invalid Port: ".$self->{_port}.""
	unless ( PORT_MAX > $self->{_port} && $self->{_port} < PORT_MAX );

    croak "Invalid host syntax: "
	.$self->{_host}.", sample: http://"
	.$self->{_ip}.":"
	.$self->{_port}."."
	unless ( $self->{_host} =~ /^http:\/\/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\:\d{1,5}$/ );
}

sub getSnippets {
    my ($self) = @_;
    # Simple GET request for testing purposes
    $self->{_client}->GET('/snippets/');
    if (index($self->{_client}->responseContent(), "Can\'t connect to") != -1) {
	croak "Server is unavailable at IP: "
	    .$self->{_ip}." and Port: "
	    .$self->{_port}.".";
    }
    return decode_json $self->{_client}->responseContent();
}

# Module further implementation here

1;
