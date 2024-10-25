package main

import (
	"bufio"
	"fmt"
	"net"
	"os"
)

func main() {
	port := os.Getenv("HTTP_SERVER_PORT")
	if port == "" {
		panic("HTTP_SERVER_PORT environment variable is not set")
	}

	listener, err := net.Listen("tcp", ":"+port)
	if err != nil {
		panic(err)
	}
	fmt.Printf("Server is running on port %s\n", port)
	for {
		conn, err := listener.Accept()
		if err != nil {
			continue
		}
		go handleConnection(conn)
	}
}

func handleConnection(conn net.Conn) {
	defer conn.Close()
	reader := bufio.NewReader(conn)
	_, err := reader.ReadString('\n')
	if err != nil {
		return
	}
	fmt.Fprintf(conn, "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!")
}
