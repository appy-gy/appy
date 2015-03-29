Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
RatingConstants = require '../constants/ratings'

class RatingActionCreators extends Marty.ActionCreators
  append: autoDispatch RatingConstants.APPEND_RATINGS
  change: autoDispatch RatingConstants.CHANGE_RATING

module.exports = Marty.register RatingActionCreators
