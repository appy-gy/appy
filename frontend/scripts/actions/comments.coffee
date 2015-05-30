Marty = require 'marty'
Constants = require '../constants'
Comment = require '../models/comment'

class CommentsActions extends Marty.ActionCreators
  create: (ratingId, data) ->
    @app.commentsApi.create(ratingId, data).then ({body}) =>
      return unless body?
      comment = new Comment body.comment
      @dispatch Constants.APPEND_COMMENTS, comment

module.exports = CommentsActions
