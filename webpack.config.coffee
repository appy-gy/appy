_ = require 'lodash'
dotenv = require 'dotenv'
path = require 'path'
webpack = require 'webpack'
ExtractTextPlugin = require 'extract-text-webpack-plugin'
AssetsPlugin = require 'assets-webpack-plugin'
ModernizrPlugin = require 'modernizr-webpack-plugin'

dotenv.load()

app = ['./frontend/app']

env = _.pick process.env, 'NODE_ENV', 'TOP_ENV', 'TOP_HOST', 'TOP_ASSETS_HOST'
definePluginEnv = _.transform env, (result, value, key) ->
  result["process.env.#{key}"] = JSON.stringify value

plugins = [
  new ExtractTextPlugin('[name].[hash].css', disable: process.env.TOP_ENV != 'production')
]

cssLoaders = ['css', 'autoprefixer']
sassLoaders = cssLoaders.concat 'sass'
[cssLoader, sassLoader] = [cssLoaders, sassLoaders].map (loaders) ->
  ExtractTextPlugin.extract 'style', loaders.join('!')
cjsxLoaders = ['coffee', 'cjsx']

modernizrConfig =
  filename: 'modernizr.js'
  'feature-detects': ['touchevents']

switch process.env.TOP_ENV
  when 'production'
    debug = false
    devtool = null
    filename = '[name].[hash].js'
    publicPath = "#{process.env.TOP_ASSETS_HOST}/static/"
    modernizrConfig.minify = true

    plugins.push \
      new webpack.optimize.OccurenceOrderPlugin(),
      new webpack.optimize.UglifyJsPlugin(compress: { warnings: false }),
      new webpack.optimize.DedupePlugin(),
      new AssetsPlugin(path: path.join(__dirname, 'tmp/webpack'), filename: 'assets.json')
  when 'development'
    debug = true
    devtool = 'eval'
    filename = '[name].js'
    publicPath = "#{process.env.TOP_WEBPACK_HOST}/"
    modernizrConfig.minify = false

    app.unshift \
      "webpack-dev-server/client?#{process.env.TOP_WEBPACK_HOST}",
      'webpack/hot/dev-server'

    plugins.push new webpack.HotModuleReplacementPlugin()

    cjsxLoaders.unshift 'react-hot'

plugins.push \
  new ModernizrPlugin(modernizrConfig),
  new webpack.DefinePlugin(definePluginEnv),
  new webpack.NoErrorsPlugin()

module.exports =
  entry:
    app: app
  output:
    path: path.join(__dirname, 'public/static')
    filename: filename
    publicPath: publicPath
  debug: debug
  devtool: devtool
  plugins: plugins
  resolve:
    extensions: ['', '.js', '.coffee', '.cjsx']
  module:
    loaders: [
      { test: /\.woff|ttf|otf|eot((\?|#).*)?|svg((\?|#).*)$/, loader: 'file' }
      { test: /\.(jpe?g|gif|png|svg)$/, loader: 'file' }
      { test: /\.css$/, loader: cssLoader }
      { test: /\.sass$/, loader: sassLoader + '?indentedSyntax' }
      { test: /\.scss$/, loader: sassLoader }
      { test: /\.coffee$/, exclude: /node_modules/, loader: 'coffee' }
      { test: /\.cjsx$/, exclude: /node_modules/, loaders: cjsxLoaders }
    ]
