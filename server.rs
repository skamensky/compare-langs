use std::env;
use std::net::{TcpListener, TcpStream};
use std::io::prelude::*;

const RESPONSE: &str = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!";

fn handle_client(mut stream: TcpStream) {
    let mut buffer = [0; 512];
    if let Ok(_) = stream.read(&mut buffer) {
        stream.write(RESPONSE.as_bytes()).unwrap();
        stream.flush().unwrap();
    }
}

fn main() {
    let port = env::var("HTTP_SERVER_PORT").expect("Environment variable HTTP_SERVER_PORT is not set");
    let address = format!("0.0.0.0:{}", port);

    let listener = TcpListener::bind(&address).unwrap_or_else(|_| {
        eprintln!("Failed to bind to address: {}", address);
        std::process::exit(1);
    });

    println!("Running on port {}...", port);

    for stream in listener.incoming() {
        match stream {
            Ok(stream) => {
                handle_client(stream);
            }
            Err(e) => {
                eprintln!("Failed to accept connection: {}", e);
            }
        }
    }
}
