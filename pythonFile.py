from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse, parse_qs
import torch
from langchain_openai import ChatOpenAI
from transformers import AutoModelForCausalLM, AutoTokenizer

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


# 1. Asset Discovery: Discovers LLM SDKs and models (OpenAI, Hugging Face)
llm = ChatOpenAI(model_name="gpt-4o", temperature=0.7)
# 2. High-Risk Model Loading: trust_remote_code=True allows arbitrary repository code execution on load
model_id = "deepseek-ai/DeepSeek-R1"
tokenizer = AutoTokenizer.from_pretrained(model_id, trust_remote_code=True)
model = AutoModelForCausalLM.from_pretrained(model_id, trust_remote_code=True)
# 3. Model Deserialization Risk: torch.load without weights_only=True evaluates pickle opcodes
def load_custom_weights(weight_path="custom_model.pt"):
    weights = torch.load(weight_path, weights_only=False)
    return weights

w = load_custom_weights()

server = HTTPServer(("0.0.0.0", 8080), Handler)
print("Server running at http://localhost:8080/entry?params=Hello")
server.serve_forever()
