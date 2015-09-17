React = require 'react/addons'
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
    <IndexRoute name="root" component={Ratings}/>
    <Route name="ratings" path="page:page?" component={Ratings}/>
    <Route name="rating" path="ratings/:ratingSlug" component={Rating}/>
    <Route name="section" path="sections/:sectionSlug" component={SectionRatings}/>
    <Route name="user" path="users/:userSlug" component={User}/>
    <Route name="instagram" path="instagram" component={Instagram}/>
    <Route name="notFound" path="*" component={NotFound}/>
  </Route>

module.exports = routes
