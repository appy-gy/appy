Base = require './base'
Section = require './section'
Tag = require './tag'

class Rating extends Base
  @hasOne 'section', Section
  @hasMany 'tags', Tag

module.exports = Rating
