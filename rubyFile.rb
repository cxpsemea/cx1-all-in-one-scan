require 'webrick'
require 'uri'

def load_user_lib
    @libname = params[:libname]

      require @libname
end

password = "Checkmarx!123"
puts "Hello World #{password}"

server = WEBrick::HTTPServer.new(:Port => 8080)

server.mount_proc "/entry" do |req, res|
  params = req.query["params"] || "No 'params' provided"
  passw = req.query["passw"] || "No 'passw' provided"

  res['Content-Type'] = 'application/html'
  res.body = ""
  if passw == password 
    res.body = "Value of params: #{params}"
  end
end

trap("INT") { server.shutdown }

puts "Server running at http://localhost:8080/entry?params=Hello"
server.start
