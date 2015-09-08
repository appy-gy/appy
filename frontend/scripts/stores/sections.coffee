_ = require 'lodash'
toArray = require '../helpers/to_array'
React = require 'react/addons'
Marty = require 'marty'
Constants = require '../constants'
findInStore = require '../helpers/find_in_store'

{update} = React.addons

class SectionsStore extends Marty.Store
  constructor: ->
    super
    @handlers =
      append: Constants.APPEND_SECTIONS

  getInitialState: ->
    []

  getAll: ->
    @fetch
      id: 'getAll'
      locally: ->
        return unless @hasAlreadyFetched 'getAll'
        @state
      remotely: ->
        @app.sectionsQueries.getAll()

  get: (id) ->
    @fetch
      id: "get-#{id}"
      locally: ->
        return unless @hasAlreadyFetched "get-#{id}"
        findInStore @, id
      remotely: ->
        @app.sectionsQueries.get(id)

  append: (sections) ->
    @state = update @state, $push: toArray(sections)

module.exports = SectionsStore
