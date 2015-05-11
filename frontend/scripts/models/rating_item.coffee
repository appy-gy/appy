Base = require './base'
Vote = require './vote'

class RatingItem extends Base
  @hasOne 'vote', Vote

module.exports = RatingItem
