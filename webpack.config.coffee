_ = require 'lodash'
dotenv = require 'dotenv'
path = require 'path'
mapObj = require 'map-obj'
webpack = require 'webpack'
ExtractTextPlugin = require 'extract-text-webpack-plugin'

dotenv.load()

[debug, devtool] = if process.env.TOP_ENV == 'development' then [true, 'eval'] else [false, null]

cssLoaders = ['css-loader', 'autoprefixer-loader']
sassLoaders = cssLoaders.concat 'sass-loader?indentedSyntax=sass'
loaderGenerator = if process.env.TOP_ENV == 'development'
  (loaders) -> ['style-loader'].concat(loaders).join('!')
else
  (loaders) -> ExtractTextPlugin.extract 'style-loader', loaders
[cssLoader, sassLoader] = [cssLoaders, sassLoaders].map loaderGenerator

env = _.pick process.env, 'NODE_ENV'
definePluginEnv = mapObj env, (key, value) ->
  ["process.env.#{key}", JSON.stringify(value)]

plugins = [
  new webpack.PrefetchPlugin 'react'
  new webpack.PrefetchPlugin 'react/lib/ReactComponentBrowserEnvironment'
]

if process.env.TOP_ENV == 'production'
  plugins.push \
    new ExtractTextPlugin 'app.css'
    new webpack.optimize.UglifyJsPlugin compress: { warnings: false }
    new webpack.optimize.DedupePlugin()
else
  plugins.push new webpack.HotModuleReplacementPlugin()

plugins.push \
  new webpack.DefinePlugin definePluginEnv
  new webpack.NoErrorsPlugin()

module.exports =
  entry:
    app: [
      "webpack-dev-server/client?#{process.env.TOP_WEBPACK_HOST}"
      'webpack/hot/dev-server'
      './frontend/app'
    ]
  output:
    path: path.join(__dirname, 'public/assets')
    filename: 'app.js'
    publicPath: "#{process.env.TOP_WEBPACK_HOST}/"
  debug: debug
  devtool: devtool
  plugins: plugins
  resolve:
    extensions: ['', '.js', '.coffee', '.cjsx']
  module:
    loaders: [
      { test: /\.woff|ttf|otf|eot((\?|#).*)?|svg((\?|#).*)$/, loader: 'file-loader' }
      { test: /\.(jpe?g|gif|png|svg)$/, loader: 'file-loader' }
      { test: /\.css$/, loader: cssLoader }
      { test: /\.s(a|c)ss$/, loader: sassLoader }
      { test: /\.js$/, include: /node_modules\/marty/, loader: 'babel-loader' }
      { test: /\.coffee$/, exclude: /node_modules/, loader: 'coffee' }
      { test: /\.cjsx$/, exclude: /node_modules/, loaders: ['react-hot', 'coffee', 'cjsx'] }
    ]
