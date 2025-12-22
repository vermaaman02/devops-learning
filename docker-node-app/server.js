
// Simple HTTP server in Node.js

const http = require("http");

// Server create kar rahe hain
const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end("Hello from Node.js inside Docker!\n");
});

// Port decide kar rahe hain
const PORT = process.env.PORT || 3000;
// Agar environment variable PORT set hoga to woh use hoga
// Warna default 3000 hoga

// Server start karo
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
