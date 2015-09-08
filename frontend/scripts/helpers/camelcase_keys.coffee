_ = require 'lodash'

camelcaseKeys = (obj) ->
  _.mapKeys obj, (value, key) -> _.camelCase key

module.exports = camelcaseKeys
