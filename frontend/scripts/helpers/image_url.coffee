_ = require 'lodash'

imageUrl = (value, size) ->
  return '' unless value?
  return value unless value? and size?
  return value if _.startsWith value, 'blob:'
  value.replace /\/([^\/]+)$/, (match, submatch) ->
    "/#{size}_#{submatch}"

module.exports = imageUrl
