Marty = require 'marty'
CommentConstants = require '../constants/comments'
CommentsApi = require '../state_sources/comments'
Comment = require '../models/comment'

class CommentQueries extends Marty.Queries
  @id: 'CommentQueries'

  getForRating: (ratingId) ->
    CommentsApi.for(@).loadForRating(ratingId).then ({body, status}) =>
      return if status == 400
      comments = body.comments.map (comment) -> new Comment comment
      @dispatch CommentConstants.APPEND_COMMENTS, comments

  getForUser: (userId) ->
    CommentsApi.for(@).loadForUser(userId).then ({body}) =>
      return unless body?
      comments = body.comments.map (comment) -> new Comment comment
      @dispatch CommentConstants.APPEND_COMMENTS, comments

module.exports = Marty.register CommentQueries
