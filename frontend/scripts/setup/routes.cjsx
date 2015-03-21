React = require 'react/addons'
Router = require 'react-router'
App = require '../components/app'
Ratings = require '../components/ratings/page'
Rating = require '../components/rating/page'
User = require '../components/user/page'

{Route, DefaultRoute, HistoryLocation} = Router

routes =
  <Route handler={App} path="/">
    <DefaultRoute name="ratings" handler={Ratings}/>
    <Route name="rating" path="ratings/:rating_id" handler={Rating}/>
    <Route name="user" path="users/vasya" handler={User}/>
  </Route>

module.exports = ->
  Router.run routes, HistoryLocation, (Handler, state) ->
    React.render <Handler {...state.params}/>, document.body
