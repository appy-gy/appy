React = require 'react/addons'
Router = require 'react-router'
App = require '../components/app'
Ratings = require '../components/ratings/previews'
Rating = require '../components/ratings/single'

{Route, DefaultRoute, HistoryLocation} = Router

routes =
  <Route handler={App} path="/">
    <DefaultRoute name="ratings" handler={Ratings}/>
    <Route name="rating" path="ratings/:id" handler={Rating}/>
  </Route>

module.exports = ->
  Router.run routes, HistoryLocation, (Handler, state) ->
    React.render <Handler {...state.params}/>, document.body
