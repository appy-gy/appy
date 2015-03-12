env = require './.env.coffee'
webpack = require 'webpack'
WebpackDevServer = require 'webpack-dev-server'
config = require './webpack.config'

compiler = webpack config

server = new WebpackDevServer compiler,
  hot: true
  contentBase: "http://#{env.WEBPACK_PORT}:#{env.WEBPACK_HOST}/public/assets"
  inline: true

server.listen env.WEBPACK_PORT, env.WEBPACK_HOST, ->
