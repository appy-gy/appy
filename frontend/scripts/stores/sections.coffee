_ = require 'lodash'
toArray = require '../helpers/to_array'
React = require 'react/addons'
Marty = require 'marty'
SectionConstants = require '../constants/sections'
SectionQueries = require '../queries/sections'
Section = require '../models/section'
findInStore = require '../helpers/find_in_store'

{update} = React.addons

class SectionsStore extends Marty.Store
  @id: 'SectionsStore'

  constructor: ->
    super
    @handlers =
      append: SectionConstants.APPEND_SECTIONS

  getInitialState: ->
    []

  rehydrate: (state) ->
    sections = state.map (section) -> new Section section
    @append sections

  getAll: ->
    @fetch
      id: 'getAll'
      locally: ->
        return unless @hasAlreadyFetched 'getAll'
        @state
      remotely: ->
        SectionQueries.for(@).getAll()

  get: (id) ->
    @fetch
      id: "get-#{id}"
      locally: ->
        return unless @hasAlreadyFetched "get-#{id}"
        findInStore @, id
      remotely: ->
        SectionQueries.for(@).get(id)

  append: (sections) ->
    @state = update @state, $push: toArray(sections)

module.exports = Marty.register SectionsStore
