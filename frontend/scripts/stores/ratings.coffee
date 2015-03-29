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
        RatingQueries.getPage page

  get: (id) ->
    @fetch
      id: "get-#{id}"
      locally: ->
        _.find @state, (rating) -> rating.id == id
      remotely: ->
        RatingQueries.get id

  change: (id, changes) ->
    rating = _.find @state, (r) -> r.id == id
    return unless rating?
    rating.update changes
    @hasChanged()

  append: (ratings) ->
    @state = update @state, $push: toArray(ratings)

module.exports = Marty.register RatingsStore
