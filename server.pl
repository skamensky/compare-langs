use IO::Socket::INET;
use strict;
use warnings;

# Get port from environment variable
my $port = $ENV{"HTTP_SERVER_PORT"};

# Exit if port is not defined
if (!defined $port) {
    die "Error: HTTP_SERVER_PORT environment variable is not set.\n";
}

my $response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!";

my $server = IO::Socket::INET->new(
    LocalPort => $port,
    Type      => SOCK_STREAM,
    Reuse     => 1,
    Listen    => SOMAXCONN
) or die "Couldn't start server on port $port: $@\n";

print "Running on port $port...\n";

while (my $client = $server->accept()) {
    my $request = '';
    $client->recv($request, 1024);
    print $client $response;
    close $client;
}
