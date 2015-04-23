Marty = require 'marty'

class CommentsStore extends Marty.Store
  constructor: ->
    super
    @state = []
    @handlers =
      change: RatingConstants.CHANGE_RATING
      append: RatingConstants.APPEND_RATINGS

  rehydrate: (state) ->
    ratings = state.map (rating) -> new Rating rating
    @append ratings

  getPage: (page) ->
    id = "getPage-#{page}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        @state
      remotely: ->
        RatingQueries.for(@).getPage(page)

  getForUser: (userId) ->
    id = "getForUser-#{userId}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        @state
      remotely: ->
        RatingQueries.for(@).getForUser(userId)

  get: (id) ->
    @fetch
      id: "get-#{id}"
      locally: ->
        _.find @state, (rating) -> rating.id == id
      remotely: ->
        RatingQueries.for(@).get(id)

  append: (ratings) ->
    @state = update @state, $push: toArray(ratings)

module.exports = Marty.register CommentsStore
