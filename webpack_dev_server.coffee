_ = require 'lodash'
dotenv = require 'dotenv'
webpack = require 'webpack'
WebpackDevServer = require 'webpack-dev-server'
config = require './webpack.config'

dotenv.load()

compiler = webpack config

server = new WebpackDevServer compiler,
  hot: true
  inline: true
  noInfo: true

[host, port] = _.last(process.env.TOP_WEBPACK_HOST.split('/')).split(':')
port = _.parseInt port

server.listen port, host, ->
