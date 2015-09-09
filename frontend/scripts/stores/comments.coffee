Marty = require 'marty'
React = require 'react/addons'
toArray = require '../helpers/to_array'
findInStore = require '../helpers/find_in_store'
Constants = require '../constants'

{update} = React.addons

class CommentsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      append: Constants.APPEND_COMMENTS

  getInitialState: ->
    []

  getForRating: (ratingId) ->
    id = "getForRating-#{ratingId}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        findInStore @, ratingId, all: true, fields: ['rating.id', 'rating.slug']
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
