React = require 'react/addons'
Router = require 'react-router'
App = require './components/app'
Ratings = require './components/ratings/page'
Rating = require './components/rating/page'
User = require './components/user/page'
Instagram = require './components/instagram/page'

{Route, DefaultRoute} = Router

routes =
  <Route handler={App} path="/">
    <DefaultRoute name="ratings" handler={Ratings}/>
    <Route name="rating" path="ratings/:ratingId" handler={Rating}/>
    <Route name="user" path="users/:userSlug" handler={User}/>
    <Route name="instagram" path="instagram" handler={Instagram}/>
  </Route>

module.exports = routes
