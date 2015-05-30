React = require 'react/addons'
Router = require 'react-router'
Marty = require 'marty'
routes = require './routes'

{HistoryLocation} = Router
{ApplicationContainer} = Marty

module.exports = ->
  app = require './application'

  Router.run routes, HistoryLocation, (Handler, state) ->
    container = \
      <ApplicationContainer app={app}>
        <Handler {...state.params}/>
      </ApplicationContainer>

    React.render container, document.body
