_ = require 'lodash'
toArray = require '../helpers/to_array'
React = require 'react/addons'
Marty = require 'marty'
SectionConstants = require '../constants/sections'
SectionQueries = require '../queries/sections'
Section = require '../models/section'

{update} = React.addons

class SectionsStore extends Marty.Store
  constructor: ->
    super
    @state = []
    @handlers =
      append: SectionConstants.APPEND_SECTIONS

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

  append: (sections) ->
    @state = update @state, $push: toArray(sections)

module.exports = Marty.register SectionsStore
