_ = require 'lodash'
toArray = require '../helpers/to_array'
React = require 'react/addons'
Marty = require 'marty'
SectionConstants = require '../constants/sections'
SectionsQueries = require '../queries/sections'

{update} = React.addons

class SectionsStore extends Marty.Store
  constructor: ->
    super
    @state = []
    @handlers =
      append: SectionConstants.APPEND_SECTIONS

  getAll: ->
    @fetch
      id: 'getAll'
      locally: ->
        return unless @hasAlreadyFetched 'getAll'
        @state
      remotely: ->
        SectionQueries.getAll()

  append: (sections) ->
    @state = update @state, $push: toArray(sections)

module.exports = Marty.register SectionsStore
