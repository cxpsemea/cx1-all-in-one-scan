local socket = require("socket")

local password = "Checkmarx!123"
print("Hello, World! " .. password)
username = ngx.req.get_uri_args()['username']

ngx.say('<p>' .. username .. '</p>')