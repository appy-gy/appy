React = require 'react'
Router = require 'react-router'
isClient = require './helpers/is_client'
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


{Route, IndexRoute} = Router

scrollTop = ->
  scroll 0, 0 if isClient()

routes =
  <Route component={App} path="/">
    <IndexRoute component={Ratings} onEnter={scrollTop}/>
    <Route path="search(/:query)" component={Search}/>
    <Route path=":sectionSlug" component={SectionRatings} onEnter={scrollTop}/>
    <Route path="users/:userSlug" component={User}/>
    <Route path="pages/:pageSlug" component={Page}/>
    <Route path="tags/:tagSlug" component={Tag} onEnter={scrollTop}/>
    <Route path=":sectionSlug/:ratingSlug" component={Rating} onEnter={scrollTop}/>
    <Route path="ratings/:ratingSlug/edit" component={Rating}/>
    <Route path="instagram" component={Instagram}/>
    <Route path="*" component={NotFound}/>
  </Route>

module.exports = routes
