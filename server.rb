require 'socket'

PORT = ENV['HTTP_SERVER_PORT']

if PORT.nil?
  puts "Error: HTTP_SERVER_PORT environment variable is missing."
  exit 1
end

RESPONSE = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!"

server = TCPServer.new(PORT.to_i)
puts "Running on port #{PORT}..."

loop do
  client = server.accept
  request = client.gets
  client.print RESPONSE
  client.close
end
