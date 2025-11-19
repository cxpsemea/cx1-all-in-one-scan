#!/usr/bin/env groovy

import com.sun.net.httpserver.*

def password = "Checkmarx!123"
println "Hello World! $password"

// --- Create server on port 8080 ---
def server = HttpServer.create(new InetSocketAddress(8080), 0)

// --- Define the /entry endpoint ---
server.createContext("/entry") { HttpExchange exchange ->

    def query = exchange.requestURI.query ?: ""
    def params = query
            .split('&')
            .collectEntries { part ->
                def (k, v) = part.split('=') + [""]
                [(k): v]
            }

    def value = params["params"] ?: "No 'params' provided"
    def pass = params["pass"] ?: "No 'pass' provided"

    String response = ""
    
    if (pass != password) {
        response = "Value of params: ${value}"
    }
    
    exchange.responseHeaders.add("Content-Type", "text/plain; charset=utf-8")
    exchange.sendResponseHeaders(200, response.bytes.length)

    exchange.responseBody.withWriter { it << response }
}

// Start the server
server.executor = null
server.start()

println "Server running on http://localhost:8080/entry?params=Hello"
