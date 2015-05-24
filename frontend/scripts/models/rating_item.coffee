Base = require './base'
Vote = require './vote'

class RatingItem extends Base
  @imageFields 'image'
  
  @hasOne 'vote', Vote

module.exports = RatingItem
