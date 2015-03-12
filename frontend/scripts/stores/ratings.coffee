_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
RatingsConstants = require '../constants/ratings'
RatingsApi = require '../state_sources/ratings'
Rating = require '../models/rating'

{update} = React.addons

RatingsStore = Marty.createStore
  handlers:
    append: RatingsConstants.APPEND_RATINGS

  getInitialState: ->
    []

  getPage: (page) ->
    id = "getPage-#{page}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        @state
      remotely: ->
        RatingsApi.loadPage page

  get: (id) ->
    @fetch
      id: "get-#{id}"
      locally: =>
        console.log 'locally'
        return unless @hasAlreadyFetched "get-#{id}"
        _.find @state, (rating) -> rating.id == id
      remotely: ->
        console.log 'remotely'
        RatingsApi.load id

  append: (ratings) ->
    @state = update @state, $push: ratings

module.exports = RatingsStore
