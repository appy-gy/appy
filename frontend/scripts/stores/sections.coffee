_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
SectionsConstants = require '../constants/sections'
SectionsApi = require '../state_sources/sections'

{update} = React.addons

SectionsStore = Marty.createStore
  handlers:
    append: SectionsConstants.APPEND_SECTIONS

  getInitialState: ->
    []

  getAll: ->
    @fetch
      id: 'all-sections'
      locally: ->
        return unless @hasAlreadyFetched 'all-sections'
        @state
      remotely: ->
        SectionsApi.getAll()

  append: (sections) ->
    console.log 'append', sections
    @state = update @state, $push: sections

module.exports = SectionsStore
