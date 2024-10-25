import java.io.*;
import java.net.*;

public class Server {
    private static final String RESPONSE = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!";

    public static void main(String[] args) {
        String portStr = System.getenv("HTTP_SERVER_PORT");
        if (portStr == null) {
            System.err.println("Error: Environment variable 'HTTP_SERVER_PORT' is not set.");
            System.exit(1);
        }

        int port;
        try {
            port = Integer.parseInt(portStr);
        } catch (NumberFormatException e) {
            System.err.println("Error: HTTP_SERVER_PORT must be a valid integer.");
            System.exit(1);
            return;
        }

        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("Running on port " + port + "...");

            while (true) {
                try (Socket clientSocket = serverSocket.accept()) {
                    OutputStream output = clientSocket.getOutputStream();
                    output.write(RESPONSE.getBytes());
                    output.flush();
                } catch (IOException e) {
                    System.err.println("Failed to handle client connection: " + e.getMessage());
                }
            }
        } catch (IOException e) {
            System.err.println("Failed to start server: " + e.getMessage());
        }
    }
}
