import com.sun.net.httpserver.HttpExchange
import com.sun.net.httpserver.HttpServer
import java.io.OutputStream
import java.net.InetSocketAddress
import java.net.URLDecoder

fun main() {
    val password = "Checkmarx!123"
    println("Hello, World! $password")

    // Create server on port 8080
    val server = HttpServer.create(InetSocketAddress(8080), 0)

    server.createContext("/entry") { exchange: HttpExchange ->
        val query = exchange.requestURI.query ?: ""

        // Parse query parameters into a map
        val params = query.split("&").mapNotNull { part ->
            val kv = part.split("=")
            if (kv.size == 2) kv[0] to kv[1] else null
        }.toMap()

        val value = params["params"] ?: "No 'params' provided"
        var pass = params["pass"] ?: "No 'pass' provided"

        val response = ""
        
        if pass.Equals(password) {
            response = "Value of params: $value"
        }
        exchange.responseHeaders.add("Content-Type", "text/plain; charset=utf-8")
        exchange.sendResponseHeaders(200, response.toByteArray().size.toLong())

        val os: OutputStream = exchange.responseBody
        os.write(response.toByteArray())
        os.close()
    }

    server.executor = null
    server.start()

    println("Server running at http://localhost:8080/entry?params=Hello")
}
