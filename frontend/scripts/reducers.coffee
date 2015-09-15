_ = require 'lodash'

reqReducers = require.context './reducers'
reducers = _ reqReducers.keys()
  .filter (path) -> not _.endsWith path, '.coffee'
  .transform ((result, path) -> result[_.camelCase(path.replace(/^\.\//, ''))] = reqReducers path), {}
  .value()

module.exports = reducers
