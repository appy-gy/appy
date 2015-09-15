_ = require 'lodash'
fs = require 'fs'

files = fs.readdirSync './frontend/scripts/reducers'
reducers = _.transform files, (result, file) ->
  name = _.camelCase file.replace(/\.coffee$/, '')
  result[name] = require "../../frontend/scripts/reducers/#{file}"
, {}

module.exports = reducers
