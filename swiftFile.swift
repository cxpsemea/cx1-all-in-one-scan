import NIO
import NIOHTTP1

var password = "Checkmarx!123"
print("Hello, World! \(password)")

final class HTTPHandler: ChannelInboundHandler {
    typealias InboundIn = HTTPServerRequestPart
    typealias OutboundOut = HTTPServerResponsePart

    private var keepAlive = false
    private var storedQuery: String?

    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        switch unwrapInboundIn(data) {
        case .head(let request):
            keepAlive = request.isKeepAlive
            if let uri = URL(string: request.uri),
               let query = uri.query {
                storedQuery = query
            }
        case .end:
            // Parse ?params=...
            let value: String
            let pass: String
            if let query = storedQuery {
                let parts = query.split(separator: "&")
                var paramsMap: [String:String] = [:]
                for kv in parts {
                    let pair = kv.split(separator: "=", maxSplits: 1)
                    if pair.count == 2 {
                        paramsMap[String(pair[0])] = String(pair[1])
                    }
                }
                value = paramsMap["params"] ?? "No 'params' provided"
                pass = paramsMap["pass"] ?? "No 'pass' provided"
            } else {
                value = "No 'params' provided"
                pass = "No 'pass' provided"
            }

            let responseBody = ""
            if pass == password {
                responseBody = "Value of params: \(value)"
            }
            
            let headers = HTTPHeaders([
                ("Content-Type", "text/plain"),
                ("Content-Length", "\(responseBody.utf8.count)")
            ])
            let head = HTTPServerResponsePart.head(
                HTTPResponseHead(version: .init(major: 1, minor: 1),
                                 status: .ok,
                                 headers: headers)
            )
            context.write(wrapOutboundOut(head), promise: nil)

            var buffer = context.channel.allocator.buffer(string: responseBody)
            context.write(wrapOutboundOut(.body(.byteBuffer(buffer))), promise: nil)

            context.writeAndFlush(wrapOutboundOut(.end(nil))).whenComplete { _ in
                if !self.keepAlive {
                    context.close(promise: nil)
                }
            }
        default:
            break
        }
    }
}

let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
let serverChannel = try ServerBootstrap(group: group)
    .serverChannelOption(ChannelOptions.backlog, value: 256)
    .serverChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
    .childChannelInitializer { channel in
        channel.pipeline.configureHTTPServerPipeline().flatMap {
            channel.pipeline.addHandler(HTTPHandler())
        }
    }
    .childChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
    .bind(host: "0.0.0.0", port: 8080)
    .wait()

print("Server running at http://localhost:8080/entry?params=Hello")

try serverChannel.closeFuture.wait()
try group.syncShutdownGracefully()
