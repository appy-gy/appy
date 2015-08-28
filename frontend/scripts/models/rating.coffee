Base = require './base'
Section = require './section'
Tag = require './tag'
Like = require './like'

class Rating extends Base
  @dateFields @dateFields()..., 'publishedAt'
  @imageFields 'image'

  @hasOne 'section', Section
  @hasOne 'like', Like
  @hasMany 'tags', Tag

module.exports = Rating
