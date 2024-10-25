const http = require('http');

const PORT = process.env.HTTP_SERVER_PORT;
if (!PORT) {
  console.error('Error: HTTP_SERVER_PORT environment variable is missing.');
  process.exit(1);
}

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello, World!');
});

server.listen(PORT, () => {
  console.log(`Running on port ${PORT}...`);
});
