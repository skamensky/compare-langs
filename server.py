import os
import socket
import sys

HOST = '0.0.0.0'
RESPONSE = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!"

def main():
    # Get port from environment variable
    port_str = os.getenv("HTTP_SERVER_PORT")
    if port_str is None:
        print("Error: Environment variable 'HTTP_SERVER_PORT' is not set.", file=sys.stderr)
        sys.exit(1)
    
    try:
        PORT = int(port_str)
    except ValueError:
        print("Error: Environment variable 'HTTP_SERVER_PORT' must be a valid integer.", file=sys.stderr)
        sys.exit(1)

    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
        server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server_socket.bind((HOST, PORT))
        server_socket.listen(3)
        print(f"Running on port {PORT}...")

        while True:
            client_socket, client_address = server_socket.accept()
            with client_socket:
                client_socket.recv(0)
                client_socket.sendall(RESPONSE.encode())

if __name__ == "__main__":
    main()
