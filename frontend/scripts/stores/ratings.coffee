_ = require 'lodash'
toArray = require '../helpers/to_array'
findInArray = require '../helpers/find_in_array'
findInStore = require '../helpers/find_in_store'
findIndexInStore = require '../helpers/find_index_in_store'
React = require 'react/addons'
Marty = require 'marty'
Constants = require '../constants'

{update} = React.addons

class RatingsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      change: Constants.CHANGE_RATING
      replace: Constants.REPLACE_RATING
      append: Constants.APPEND_RATINGS
      remove: Constants.REMOVE_RATING
      addTag: Constants.ADD_TAG_TO_RATING
      removeTag: Constants.REMOVE_TAG_FROM_RATING

  getInitialState: ->
    []

  getPage: (page) ->
    id = "getPage-#{page}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        findInStore @, page, all: true, fields: ['page']
      remotely: ->
        @app.ratingsQueries.getPage(page)

  getForUser: (userId, page) ->
    id = "getForUser-#{userId}-#{page}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        findInStore @, page, all: true, fields: ['page']
      remotely: ->
        @app.ratingsQueries.getForUser(userId, page)

  getForSection: (sectionId, page) ->
    id = "getForSection-#{sectionId}-#{page}"

    @fetch
      id: id
      locally: ->
        return unless @hasAlreadyFetched id
        findInArray findInStore(@, page, all: true, fields: ['page']), sectionId, all: true, fields: ['section.id', 'section.slug']
      remotely: ->
        @app.ratingsQueries.getForSection(sectionId, page)

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
    _.merge rating, changes
    @hasChanged()

  replace: (rating) ->
    index = findIndexInStore @, rating
    return if index < 0
    @state = update @state, $splice: [[index, 1, rating]]

  append: (ratings) ->
    @state = update @state, $push: toArray(ratings)

  remove: (ratingId) ->
    index = findIndexInStore @, ratingId
    return if index < 0
    @state = update @state, $splice: [[index, 1]]

  addTag: (ratingId, tag) ->
    rating = findInStore @, ratingId
    rating.tags.push tag
    @hasChanged()

  removeTag: (ratingId, tag) ->
    rating = findInStore @, ratingId
    _.remove rating.tags, (t) -> t.name == tag.name
    @hasChanged()

module.exports = RatingsStore
