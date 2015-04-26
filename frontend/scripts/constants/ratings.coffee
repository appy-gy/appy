Marty = require 'marty'

RatingConstants = Marty.createConstants [
  'APPEND_RATINGS'
  'CHANGE_RATING'
  'REPLACE_RATING'
  'ADD_TAG_TO_RATING'
  'REMOVE_TAG_FROM_RATING'
]

module.exports = RatingConstants
