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
Search = require './components/search/page'
Instagram = require './components/instagram/page'
onRouteChanged = require './helpers/on_route_changed'

{Route, IndexRoute} = Router

routes =
  <Route component={App} path="/">
    <IndexRoute component={Ratings} onEnter={onRouteChanged.scrollTop}/>
    <Route path="search(/:query)" component={Search}/>
    <Route path=":sectionSlug" component={SectionRatings} onEnter={onRouteChanged.scrollTop}/>
    <Route path="users/:userSlug" component={User} onEnter={onRouteChanged.scrollTop}/>
    <Route path="pages/:pageSlug" component={Page}/>
    <Route path="tags/:tagSlug" component={Tag} onEnter={onRouteChanged.scrollTop}/>
    <Route path=":sectionSlug/:ratingSlug" component={Rating} onEnter={onRouteChanged.scrollTop}/>
    <Route path="ratings/:ratingSlug/edit" component={Rating}/>
    <Route path="instagram" component={Instagram}/>
    <Route path="*" component={NotFound}/>
  </Route>

module.exports = routes
