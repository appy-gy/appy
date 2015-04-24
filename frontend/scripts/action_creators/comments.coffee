Marty = require 'marty'
CommentConstants = require '../constants/comments'
CommentsApi = require '../state_sources/comments'
Comment = require '../models/comment'

class CommentActionCreators extends Marty.ActionCreators
  create: (ratingId, data) ->
    CommentsApi.create(ratingId, data).then ({body}) =>
      return unless body?
      comment = new Comment body.comment
      @dispatch CommentConstants.APPEND_COMMENTS, comment

module.exports = Marty.register CommentActionCreators
