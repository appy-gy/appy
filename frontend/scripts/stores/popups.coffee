_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
PopupsConstants = require '../constants/popups'

{update} = React.addons

PopupsStore = Marty.createStore
  handlers:
    append: PopupsConstants.APPEND_POPUPS
    remove: PopupsConstants.REMOVE_POPUPS

  getInitialState: ->
    []

  getAll: ->
    @state

  append: (popups) ->
    popups = [popups] unless _.isArray popups
    @state = update @state, $push: popups

  remove: (popups) ->
    popups = [popups] unless _.isArray popups
    @state = _.without @state, popups...

module.exports = PopupsStore
