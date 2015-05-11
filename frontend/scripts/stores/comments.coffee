toArray = require '../helpers/to_array'
Marty = require 'marty'
React = require 'react/addons'
CommentConstants = require '../constants/comments'
CommentQueries = require '../queries/comments'
Comment = require '../models/comment'

{update} = React.addons

class CommentsStore extends Marty.Store
  @id: 'CommentsStore'

  constructor: ->
    super
    @handlers =
      append: CommentConstants.APPEND_COMMENTS

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
        @state
      remotely: ->
        CommentQueries.for(@).getForRating(ratingId)

  getForUser: (userId) ->
    id = "getForuser-#{userId}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        @state
      remotely: ->
        CommentQueries.for(@).getForUser(userId)

  append: (comments) ->
    @state = update @state, $push: toArray(comments)

module.exports = Marty.register CommentsStore
