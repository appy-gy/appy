_ = require 'lodash'
toArray = require '../helpers/to_array'
findInStore = require '../helpers/find_in_store'
findIndexInStore = require '../helpers/find_index_in_store'
React = require 'react/addons'
Marty = require 'marty'
Constants = require '../constants'
Rating = require '../models/rating'

{update} = React.addons

class RatingsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      change: Constants.CHANGE_RATING
      replace: Constants.REPLACE_RATING
      append: Constants.APPEND_RATINGS
      addTag: Constants.ADD_TAG_TO_RATING
      removeTag: Constants.REMOVE_TAG_FROM_RATING

  getInitialState: ->
    []

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
        @app.ratingsQueries.getPage(page)

  getForUser: (userId) ->
    id = "getForUser-#{userId}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        @state
      remotely: ->
        @app.ratingsQueries.getForUser(userId)

  getForSection: (sectionId) ->
    id = "getForSection-#{sectionId}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        findInStore @, sectionId, all: true, fields: ['section.id', 'section.slug']
      remotely: ->
        @app.ratingsQueries.getForSection(sectionId)

  get: (id) ->
    @fetch
      id: "get-#{id}"
      locally: ->
        findInStore @, id
      remotely: ->
        @app.ratingsQueries.get(id)

  change: (ratingId, changes) ->
    rating = findInStore @, ratingId
    return unless rating?
    rating.update changes
    @hasChanged()

  replace: (rating) ->
    index = findIndexInStore @, rating
    return if index < 0
    @state = update @state, $splice: [[index, 1, rating]]

  append: (ratings) ->
    @state = update @state, $push: toArray(ratings)

  addTag: (ratingId, tag) ->
    rating = findInStore @, ratingId
    rating.tags.push tag
    @hasChanged()

  removeTag: (ratingId, tag) ->
    rating = findInStore @, ratingId
    _.remove rating.tags, (t) -> t.name == tag.name
    @hasChanged()

module.exports = RatingsStore
