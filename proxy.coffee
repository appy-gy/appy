http = require 'http'
httpProxy = require 'http-proxy'
dotenv = require 'dotenv'

dotenv.load()

server = http.createServer()
proxy = httpProxy.createProxyServer()

server.on 'request', (req, res) ->
  target = if req.method == 'GET' and req.url.match /^\/api\/private\/(sections(.*?)|header_sections|main_page_ratings|ratings(.*?)|rating_items(.*?)|users(.*?)|tags(.*?)|pages(.*?)|search(.*?))$/
      process.env.TOP_NEW_API_HOST
    else if req.url.match /^\/(api|oauth|admin|assets|static|files|system|__better_errors)/
      process.env.TOP_API_HOST
    else
      process.env.TOP_PRERENDER_HOST
  proxy.web req, res, { target }

proxy.on 'error', (error, req, res) ->
  console.error 'Failed to proxy request', error, error.stack
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
