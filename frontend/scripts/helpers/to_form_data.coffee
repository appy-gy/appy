_ = require 'lodash'
uuid = require 'node-uuid'

toFormData = (obj, data = new FormData, namespace = '') ->
  _.tap data, (data) ->
    _.each obj, (value, key) ->
      isArray = _.isArray value
      key = namespace + if _.isArray obj then '' else if _.isEmpty namespace then key else "[#{key}]"
      key += '[]' if isArray
      return data.append key, '' if isArray and _.isEmpty value
      return toFormData value, data, key if isArray or _.isPlainObject value
      return data.append key, value, value.name || uuid.v4() if value instanceof Blob
      data.append key, value

module.exports = toFormData
