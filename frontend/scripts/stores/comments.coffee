Marty = require 'marty'
React = require 'react/addons'
toArray = require '../helpers/to_array'
findInStore = require '../helpers/find_in_store'
Constants = require '../constants'
Comment = require '../models/comment'

{update} = React.addons

class CommentsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      append: Constants.APPEND_COMMENTS

  getInitialState: ->
    []

  rehydrate: (state) ->
    comments = state.map (comment) -> new Comment comment
    @append comments

  getForRating: (ratingId) ->
    id = "getForRating-#{ratingId}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        findInStore @, ratingId, all: true, fields: ['ratingId', 'ratingSlug']
      remotely: ->
        @app.commentsQueries.getForRating(ratingId)

  getForUser: (userId, page) ->
    id = "getForuser-#{userId}-#{page}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        findInStore @, page, all: true, fields: ['page']
      remotely: ->
        @app.commentsQueries.getForUser(userId, page)

  append: (comments) ->
    @state = update @state, $push: toArray(comments)

module.exports = CommentsStore
