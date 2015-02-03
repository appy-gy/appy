React = require 'react/addons'
Router = require 'react-router'
App = require '../components/app'
Ratings = require '../components/ratings/previews'

{Route, DefaultRoute, HistoryLocation} = Router

routes =
  <Route handler={App} path="/">
    <DefaultRoute handler={Ratings} />
  </Route>

module.exports = ->
  Router.run routes, HistoryLocation, (Handler) ->
    React.render <Handler/>, document.body
