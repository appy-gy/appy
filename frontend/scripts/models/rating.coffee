Base = require './base'
Section = require './section'
Tag = require './tag'
Like = require './like'

class Rating extends Base
  @hasOne 'section', Section
  @hasOne 'like', Like
  @hasMany 'tags', Tag

module.exports = Rating
