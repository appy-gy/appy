Marty = require 'marty'
Constants = require '../constants'

class CommentsActions extends Marty.ActionCreators
  create: (ratingId, data) ->
    @app.commentsApi.create(ratingId, data).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.APPEND_COMMENTS, body.comment

module.exports = CommentsActions
