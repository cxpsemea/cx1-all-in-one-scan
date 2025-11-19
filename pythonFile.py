from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse, parse_qs

password = "Pass!1234"
print("Hello, world!", password)

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        parsed = urlparse(self.path)

        if parsed.path == "/entry":
            qs = parse_qs(parsed.query)
            value = qs.get("params", ["No 'params' provided"])[0]
            passw = qs.get("pass", ["No 'pass' provided"])[0]

            response = ""
            if passw == password:
                response = f"Value of params: {value}"

            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.send_header("Content-Length", str(len(response)))
            self.end_headers()
            self.wfile.write(response)
        else:
            self.send_response(404)
            self.end_headers()
            self.wfile.write(b"Not Found")

server = HTTPServer(("0.0.0.0", 8080), Handler)
print("Server running at http://localhost:8080/entry?params=Hello")
server.serve_forever()
