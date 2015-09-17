React = require 'react'
Router = require 'react-router'
App = require './components/app'
NotFound = require './components/not_found/page'
Ratings = require './components/ratings/page'
Rating = require './components/rating/page'
SectionRatings = require './components/section/page'

User = require './components/user/page'
Instagram = require './components/instagram/page'

{Route, IndexRoute, NotFoundRoute} = Router

routes =
  <Route component={App} path="/">
    <IndexRoute component={Ratings}/>
    <Route path="ratings/:ratingSlug" component={Rating}/>
    <Route path="sections/:sectionSlug" component={SectionRatings}/>
    <Route path="users/:userSlug" component={User}/>
    <Route path="instagram" component={Instagram}/>
    <Route path="*" component={NotFound}/>
  </Route>

module.exports = routes
