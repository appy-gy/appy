http = require 'http'
httpProxy = require 'http-proxy'
dotenv = require 'dotenv'

dotenv.load()

server = http.createServer()
proxy = httpProxy.createProxyServer()

server.on 'request', (req, res) ->
  target = if req.url.match /^\/(api|system)/ then process.env.TOP_HOST else process.env.TOP_PRERENDER_HOST
  proxy.web req, res, { target }

server.listen 9292
