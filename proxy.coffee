http = require 'http'
httpProxy = require 'http-proxy'
dotenv = require 'dotenv'

dotenv.load()

server = http.createServer()
proxy = httpProxy.createProxyServer()

server.on 'request', (req, res) ->
  target = if req.url.match /^\/(api|admin|assets|system|__better_errors)/ then process.env.TOP_HOST else process.env.TOP_PRERENDER_HOST
  proxy.web req, res, { target }

proxy.on 'error', (err, req, res) ->
  console.error 'error', err
  res.end """
    <html>
      <head>
        <script type="text/javascript">
          setTimeout(function() {
            window.location.reload();
          }, 1000)
        </script>
      </head>
      <body>
        <h1>
          Will refresh in second
        </h1>
      </body>
    </html>
  """

server.listen 9292
