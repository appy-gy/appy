Base = require './base'
User = require './user'
Rating = require './rating'

class Comment extends Base
  @hasOne 'user', User
  @hasOne 'rating', Rating
  @hasOne 'parent', Comment
  @hasMany 'comments', Comment

  shortId: ->
    return unless @id?
    @id.split('-')[0]

module.exports = Comment
