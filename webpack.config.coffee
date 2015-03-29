env = require './.env.coffee'
path = require 'path'
mapObj = require 'map-obj'
webpack = require 'webpack'
ExtractTextPlugin = require 'extract-text-webpack-plugin'

[debug, devtool] = if env.TOP_ENV == 'development' then [true, 'eval'] else [false, null]

cssLoaders = ['css-loader', 'autoprefixer-loader']
sassLoaders = cssLoaders.concat 'sass-loader?indentedSyntax=sass'
loaderGenerator = if env.TOP_ENV == 'development'
  (loaders) -> ['style-loader'].concat(loaders).join('!')
else
  (loaders) -> ExtractTextPlugin.extract 'style-loader', loaders
[cssLoader, sassLoader] = [cssLoaders, sassLoaders].map loaderGenerator

definePluginEnv = mapObj env, (key, value) -> [key, JSON.stringify(value)]
definePluginEnv['process.env.NODE_ENV'] = JSON.stringify process.env.NODE_ENV

plugins = [
  new webpack.PrefetchPlugin 'react'
  new webpack.PrefetchPlugin 'react/lib/ReactComponentBrowserEnvironment'
]

if env.TOP_ENV == 'production'
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
      { test: /\.woff|ttf|otf|eot$/, loader: 'file-loader' }
      { test: /\.(jpe?g|png|svg)$/, loader: 'file-loader' }
      { test: /\.css$/, loader: cssLoader }
      { test: /\.s(a|c)ss$/, loader: sassLoader }
      { test: /\.js$/, include: /node_modules\/marty/, loader: 'babel-loader' }
      { test: /\.coffee$/, exclude: /node_modules/, loader: 'coffee' }
      { test: /\.cjsx$/, exclude: /node_modules/, loaders: ['react-hot', 'coffee', 'cjsx'] }
    ]
