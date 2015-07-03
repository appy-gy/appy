webpack = require 'webpack'
webpackConfig = require './webpack.config'

module.exports = (config) ->
  config.set
    basePath: ''
    frameworks: ['mocha', 'sinon-chai']
    files: [
      'frontend/tests/run.coffee'
    ]
    preprocessors:
      'frontend/tests/*': ['webpack']
    webpack: webpackConfig
    webpackMiddleware:
      noInfo: true
    reporters: ['spec', 'notify']
    notifyReporter:
      reportSuccess: false
    port: parseInt process.env.TOP_KARMA_PORT
    colors: true
    logLevel: config.LOG_INFO
    autoWatch: true
    singleRun: false
    browsers: []
    captureTimeout: 20000
    plugins: [
      require 'karma-webpack'
      require 'karma-mocha'
      require 'karma-sinon-chai'
      require 'karma-spec-reporter'
      require 'karma-notify-reporter'
    ]
