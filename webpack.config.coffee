_ = require 'lodash'
dotenv = require 'dotenv'
path = require 'path'
mapObj = require 'map-obj'
webpack = require 'webpack'
ExtractTextPlugin = require 'extract-text-webpack-plugin'

dotenv.load()

app = ['./frontend/app']



env = _.pick process.env, 'NODE_ENV', 'TOP_ENV', 'TOP_INSTAGRAM_KEY'
definePluginEnv = mapObj env, (key, value) ->
  ["process.env.#{key}", JSON.stringify(value)]

plugins = [
  new webpack.PrefetchPlugin 'react'
  new webpack.PrefetchPlugin 'react/lib/ReactComponentBrowserEnvironment'
  new ExtractTextPlugin '[name].css', disable: process.env.TOP_ENV != 'production'
]

cssLoaders = ['css', 'autoprefixer']
lessLoaders = cssLoaders.concat 'less'
sassLoaders = cssLoaders.concat 'sass'
[cssLoader, lessLoader, sassLoader] = [cssLoaders, lessLoaders, sassLoaders].map (loaders) ->
  ExtractTextPlugin.extract 'style', loaders.join('!')
cjsxLoaders = ['coffee', 'cjsx']

switch process.env.TOP_ENV
  when 'production'
    debug = false
    devtool = null
    publicPath = '/static/'

    plugins.push \
      new webpack.optimize.UglifyJsPlugin compress: { warnings: false },
      new webpack.optimize.DedupePlugin()
  when 'development'
    debug = true
    devtool = 'eval'
    publicPath: "#{process.env.TOP_WEBPACK_HOST}/"

    app.unshift \
      "webpack-dev-server/client?#{process.env.TOP_WEBPACK_HOST}",
      'webpack/hot/dev-server'

    plugins.push new webpack.HotModuleReplacementPlugin()

    cjsxLoaders.unshift 'react-hot'

plugins.push \
  new webpack.DefinePlugin definePluginEnv
  new webpack.NoErrorsPlugin()

module.exports =
  entry:
    app: app
  output:
    path: path.join(__dirname, 'public/static')
    filename: '[name].js'
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
      { test: /\.less$/, loader: lessLoader }
      { test: /\.sass$/, loader: sassLoader + '?indentedSyntax' }
      { test: /\.scss$/, loader: sassLoader }
      { test: /\.js$/, include: /node_modules\/marty/, loader: 'babel' }
      { test: /\.coffee$/, exclude: /node_modules/, loader: 'coffee' }
      { test: /\.cjsx$/, exclude: /node_modules/, loaders: cjsxLoaders }
    ]
