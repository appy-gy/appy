React = require 'react'
Router = require 'react-router'
App = require './components/app'
NotFound = require './components/not_found/page'
Ratings = require './components/ratings/page'
Rating = require './components/rating/page'
SectionRatings = require './components/section/page'
Page = require './components/page/page'
Tag = require './components/tag/page'
User = require './components/user/page'
Instagram = require './components/instagram/page'

{Route, IndexRoute} = Router

routes =
  <Route component={App} path="/">
    <IndexRoute component={Ratings}/>
    <Route path="ratings/:ratingSlug" component={Rating}/>
    <Route path="sections/:sectionSlug" component={SectionRatings}/>
    <Route path="users/:userSlug" component={User}/>
    <Route path="pages/:pageSlug" component={Page}/>
    <Route path="tags/:tagSlug" component={Tag}/>
    <Route path="instagram" component={Instagram}/>
    <Route path="*" component={NotFound}/>
  </Route>

module.exports = routes
