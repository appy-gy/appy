_ = require 'lodash'
pixelRatio = require './pixel_ratio'

imageUrl = (value, size) ->
  return '' unless value?
  return value unless value? and size?
  return value if _.startsWith value, 'blob:'
  value.replace /\/([^\/]+)$/, (match, submatch) ->
    "/#{size}_#{pixelRatio.get()}x_#{submatch}"

module.exports = imageUrl
