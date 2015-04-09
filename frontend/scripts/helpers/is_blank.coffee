_ = require 'lodash'

isBlank = (obj) ->
  not obj? or (_.isString(obj) and !_.trim(obj)) or _.isEmpty(obj)

module.exports = isBlank
