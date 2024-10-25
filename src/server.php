<?php

$port = getenv('HTTP_SERVER_PORT');
if ($port === false) {
    die("Environment variable 'HTTP_SERVER_PORT' is not set. Exiting program.\n");
}

$address = '0.0.0.0';
$response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!";

$socket = stream_socket_server("tcp://$address:$port", $errno, $errstr);
if (!$socket) {
    die("Couldn't start server on port $port: $errstr ($errno)\n");
}

echo "Running on port $port...\n";

while ($client = stream_socket_accept($socket)) {
    $request = fread($client, 1024);
    fwrite($client, $response);
    fclose($client);
}

fclose($socket);
?>
