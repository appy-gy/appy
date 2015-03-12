env = require './.env.coffee'
path = require 'path'
mapObj = require 'map-obj'
webpack = require 'webpack'
ExtractTextPlugin = require 'extract-text-webpack-plugin'

[debug, devtool] = if env.TOP_ENV == 'development' then [true, 'eval'] else [false, null]

definePluginEnv = mapObj env, (key, value) -> [key, JSON.stringify(value)]
definePluginEnv['process.env.NODE_ENV'] = JSON.stringify process.env.NODE_ENV

plugins = [
  new webpack.PrefetchPlugin 'react'
  new webpack.PrefetchPlugin 'react/lib/ReactComponentBrowserEnvironment'
  new ExtractTextPlugin 'app.css'
]

if env.TOP_ENV == 'production'
  plugins.push \
    new webpack.optimize.UglifyJsPlugin compress: { warnings: false }
    new webpack.optimize.DedupePlugin()
else
  plugins.push new webpack.HotModuleReplacementPlugin()

plugins.push \
  new webpack.DefinePlugin definePluginEnv
  new webpack.NoErrorsPlugin()

styleLoaders = ['css-loader', 'autoprefixer-loader'].join('!')

module.exports =
  entry:
    app: [
      "webpack-dev-server/client?http://#{env.WEBPACK_HOST}:#{env.WEBPACK_PORT}"
      'webpack/hot/dev-server'
      './frontend/app'
    ]
  output:
    path: path.join(__dirname, 'public/assets')
    filename: 'app.js'
    publicPath: "http://#{env.WEBPACK_HOST}:#{env.WEBPACK_PORT}/"
  debug: debug
  devtool: devtool
  plugins: plugins
  resolve:
    extensions: ['', '.js', '.coffee', '.cjsx']
  module:
    loaders: [
      { test: /\.ttf$/, loader: 'file-loader' }
      { test: /\.(jpe?g|png|svg)$/, loader: 'file-loader' }
      { test: /\.css$/, loader: ExtractTextPlugin.extract('style-loader', styleLoaders) }
      { test: /\.s(a|c)ss$/, loader: ExtractTextPlugin.extract('style-loader', [styleLoaders, 'sass-loader?indentedSyntax=sass'].join('!')) }
      { test: /\.coffee$/, loader: 'coffee' }
      { test: /\.cjsx$/, loaders: ['react-hot', 'coffee', 'cjsx'] }
    ]
