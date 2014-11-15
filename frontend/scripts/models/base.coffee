_ = require 'lodash'
camelizeKeys = require '../helpers/camelize_keys'

class Base
  constructor: (data = {}) ->
    _.merge @, camelizeKeys(data)

module.exports = Base
