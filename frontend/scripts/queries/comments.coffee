_ = require 'lodash'
Marty = require 'marty'
Constants = require '../constants'
Comment = require '../models/comment'

class CommentsQueries extends Marty.Queries
  getForRating: (ratingId) ->
    @app.commentsApi.loadForRating(ratingId).then ({body, status}) =>
      return unless status == 200
      comments = body.comments.map (comment) -> new Comment comment
      @dispatch Constants.APPEND_COMMENTS, comments

  getForUser: (userId, page) ->
    @app.commentsApi.loadForUser(userId, page).then ({body}) =>
      return unless body?
      comments = body.comments.map (comment) -> new Comment _.merge(comment, { page })
      @dispatch Constants.APPEND_COMMENTS, comments
      @dispatch Constants.SET_PAGES_COUNT, 'userComments', body.meta.pages_count

module.exports = CommentsQueries
