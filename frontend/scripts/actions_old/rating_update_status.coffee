Marty = require 'marty'
Constants = require '../constants'

{autoDispatch} = Marty

class RatingUpdateStatusActions extends Marty.ActionCreators
  set: autoDispatch Constants.SET_RATING_UPDATE_STATUS

module.exports = RatingUpdateStatusActions
