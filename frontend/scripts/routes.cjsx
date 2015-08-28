React = require 'react/addons'
Router = require 'react-router'
App = require './components/app'
NotFound = require './components/not_found/page'
Ratings = require './components/ratings/page'
Rating = require './components/rating/page'
SectionRatings = require './components/section/page'

User = require './components/user/page'
Instagram = require './components/instagram/page'

{Route, DefaultRoute, NotFoundRoute} = Router

routes =
  <Route handler={App} path="/">
    <DefaultRoute name="root" handler={Ratings}/>
    <Route name="ratings" path="page:page?" handler={Ratings}/>
    <Route name="rating" path="ratings/:ratingSlug" handler={Rating}/>
    <Route name="section" path="sections/:sectionSlug" handler={SectionRatings}/>
    <Route name="user" path="users/:userSlug" handler={User}/>
    <Route name="instagram" path="instagram" handler={Instagram}/>
    <NotFoundRoute handler={NotFound}/>
  </Route>

module.exports = routes
