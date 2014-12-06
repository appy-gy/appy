Base = require './base'
Section = require './section'

class Rating extends Base
  @hasOne 'section', Section

module.exports = Rating
