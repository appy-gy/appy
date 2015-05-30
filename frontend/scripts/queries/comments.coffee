Marty = require 'marty'
Constants = require '../constants'
Comment = require '../models/comment'

class CommentsQueries extends Marty.Queries
  getForRating: (ratingId) ->
    @app.commentsApi.loadForRating(ratingId).then ({body, status}) =>
      return if status == 400
      comments = body.comments.map (comment) -> new Comment comment
      @dispatch Constants.APPEND_COMMENTS, comments

  getForUser: (userId) ->
    @app.commentsApi.loadForUser(userId).then ({body}) =>
      return unless body?
      comments = body.comments.map (comment) -> new Comment comment
      @dispatch Constants.APPEND_COMMENTS, comments

module.exports = CommentsQueries
