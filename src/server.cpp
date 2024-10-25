#include <iostream>
#include <string>
#include <cstring>
#include <cstdlib>
#include <unistd.h>
#include <arpa/inet.h>

#define RESPONSE "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!"

int main() {
    int server_fd, new_socket;
    struct sockaddr_in address;
    int opt = 1;
    int addrlen = sizeof(address);

    const char* port_env = std::getenv("HTTP_SERVER_PORT");
    if(port_env == nullptr) {
        std::cerr << "Environment variable HTTP_SERVER_PORT not set" << std::endl;
        exit(EXIT_FAILURE);
    }

    int port = std::atoi(port_env);

    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }

    if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt))) {
        perror("setsockopt");
        exit(EXIT_FAILURE);
    }

    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(port);

    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }

    if (listen(server_fd, 3) < 0) {
        perror("listen");
        exit(EXIT_FAILURE);
    }

    std::cout << "Running on port " << port << "..." << std::endl;

    while (true) {
        if ((new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen)) < 0) {
            perror("accept");
            continue;
        }

        // Remove the blocking read call
        // read(new_socket, buffer, 1024);

        send(new_socket, RESPONSE, strlen(RESPONSE), 0);
        close(new_socket);
    }

    return 0;
}
