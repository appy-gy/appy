Marty = require 'marty'
CommentConstants = require '../constants/comments'
CommentsApi = require '../state_sources/comments'
Comment = require '../models/rating'

class CommentQueries extends Marty.Queries
  getForRating: (ratingId) ->
    CommentsApi.for(@).loadForRating(ratingId).then ({body}) =>
      return unless body?
      comments = body.comments.map (comment) -> new Comment comment
      @dispatch CommentConstants.APPEND_COMMENTS, comments

module.exports = Marty.register CommentQueries
