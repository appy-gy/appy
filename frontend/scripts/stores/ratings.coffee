_ = require 'lodash'
toArray = require '../helpers/to_array'
React = require 'react/addons'
Marty = require 'marty'
RatingConstants = require '../constants/ratings'
RatingQueries = require '../queries/ratings'

{update} = React.addons

class RatingsStore extends Marty.Store
  constructor: ->
    super
    @state = []
    @handlers =
      change: RatingConstants.CHANGE_RATING
      append: RatingConstants.APPEND_RATINGS

  getPage: (page) ->
    id = "getPage-#{page}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        @state
      remotely: ->
        RatingQueries.for(@).getPage(page)

  get: (id) ->
    @fetch
      id: "get-#{id}"
      locally: ->
        _.find @state, (rating) -> rating.id == id
      remotely: ->
        RatingQueries.for(@).get(id)

  change: (id, changes) ->
    index = _.findIndex @state, (rating) -> rating.id == id
    return if index < 0
    newRating =  @state[index].clone().update(changes)
    @state = update @state, $splice: [[index, 1, newRating]]

  append: (ratings) ->
    @state = update @state, $push: toArray(ratings)

module.exports = Marty.register RatingsStore
