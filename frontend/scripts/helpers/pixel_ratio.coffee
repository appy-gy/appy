defaultPixelRatio = 1
pixelRatio = null

get = ->
  pixelRatio or defaultPixelRatio

set = (value) ->
  pixelRatio = value

module.exports = { get, set }
