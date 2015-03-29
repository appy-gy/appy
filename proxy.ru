require 'dotenv'
require 'rack/reverse_proxy'

Dotenv.load

app = Rack::ReverseProxy.new do
  reverse_proxy_options matching: :first

  reverse_proxy /^\/api/, ENV['TOP_HOST']

  reverse_proxy /.*/, ENV['TOP_PRERENDER_HOST']
end

run app
