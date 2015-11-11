# Your component must define onLoginKey key

_ = require 'lodash'
React = require 'react'
isClient = require '../../helpers/is_client'

{PropTypes} = React

storageKey = 'onLoginCallbacks'

loadCallbacks = ->
  return [] unless isClient()
  JSON.parse(localStorage[storageKey] || '[]')

saveCallbacks = (callbacks) ->
  return unless isClient()
  localStorage[storageKey] = JSON.stringify callbacks

OnLogin =
  contextTypes:
    addLoginCallback: PropTypes.func.isRequired

  componentWillMount: ->
    return unless isClient()
    @removeLoginCallback = @context.addLoginCallback @runLoginCallbacks

  componentWillUnmount: ->
    @removeLoginCallback?()

  onLogin: (name, args...) ->
    callbacks = loadCallbacks()
    callbacks.push { key: @onLoginKey, name, args }
    saveCallbacks callbacks

  runLoginCallbacks: ->
    callbacks = loadCallbacks()
    [run, keep] = _.partition callbacks, ({key}) => key == @onLoginKey
    run.each ({name, args}) => @[name] args...
    saveCallbacks keep

module.exports = OnLogin
