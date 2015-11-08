_ = require 'lodash'
pixelRatio = require './pixel_ratio'

imageUrl = (value, size) ->
  return '' unless value?
  return value if _.startsWith value, 'blob:'
  value = process.env.TOP_ASSETS_HOST + value
  return value unless size?
  value.replace /\/([^\/]+)$/, (match, submatch) ->
    "/#{size}_#{pixelRatio.get()}x_#{submatch}"

module.exports = imageUrl
