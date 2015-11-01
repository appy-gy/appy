pixelRatio = require '../../frontend/scripts/helpers/pixel_ratio'

module.exports = ->
  (req, res, next) ->
    pixelRatio.set req.cookies.pixel_ratio
    next()
