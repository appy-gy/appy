React = require 'react/addons'
Router = require 'react-router'
routes = require './routes'

{HistoryLocation} = Router

module.exports = ->
  Router.run routes, HistoryLocation, (Handler, state) ->
    React.render <Handler {...state.params}/>, document.body
