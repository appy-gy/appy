_ = require 'lodash'
Marty = require 'marty'
Constants = require '../constants'

class CommentsQueries extends Marty.Queries
  getForRating: (ratingId) ->
    @app.commentsApi.loadForRating(ratingId).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.APPEND_COMMENTS, body.comments

  getForUser: (userId, page) ->
    @app.commentsApi.loadForUser(userId, page).then ({body, ok}) =>
      return unless ok
      comments = body.comments.map (comment) -> _.merge { page }, comment
      @dispatch Constants.APPEND_COMMENTS, comments
      @dispatch Constants.SET_PAGES_COUNT, 'userComments', body.meta.pagesCount

module.exports = CommentsQueries
