_ = require 'lodash'
toArray = require '../helpers/to_array'
findInStore = require '../helpers/find_in_store'
findIndexInStore = require '../helpers/find_index_in_store'
React = require 'react/addons'
Marty = require 'marty'
RatingConstants = require '../constants/ratings'
RatingQueries = require '../queries/ratings'
Rating = require '../models/rating'

{update} = React.addons

class RatingsStore extends Marty.Store
  constructor: ->
    super
    @state = []
    @handlers =
      change: RatingConstants.CHANGE_RATING
      replace: RatingConstants.REPLACE_RATING
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

  change: (ratingOrId, changes) ->
    rating = findInStore @, ratingOrId
    return unless rating?
    rating.update changes
    @hasChanged()

  replace: (ratingOrId) ->
    index = findIndexInStore @, ratingOrId
    return if index < 0
    rating = @state[index]
    @state = update @state, $splice: [[index, 1, rating]]

  append: (ratings) ->
    @state = update @state, $push: toArray(ratings)

module.exports = Marty.register RatingsStore
