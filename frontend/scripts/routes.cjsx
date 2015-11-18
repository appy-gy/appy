React = require 'react'
Router = require 'react-router'
isClient = require './helpers/is_client'
App = require './components/app'
Ratings = require './components/ratings/page'
Rating = require './components/rating/page'
SectionRatings = require './components/section/page'
Page = require './components/page/page'
Tag = require './components/tag/page'
User = require './components/user/page'

{Route, IndexRoute} = Router

scrollTop = ->
  scroll 0, 0 if isClient()

routes =
  <Route component={App} path="/">
    <IndexRoute component={Ratings} onEnter={scrollTop}/>
    <Route path=":sectionSlug" component={SectionRatings} onEnter={scrollTop}/>
    <Route path="users/:userSlug" component={User} onEnter={scrollTop}/>
    <Route path="pages/:pageSlug" component={Page} onEnter={scrollTop}/>
    <Route path="tags/:tagSlug" component={Tag} onEnter={scrollTop}/>
    <Route path=":sectionSlug/:ratingSlug" component={Rating} onEnter={scrollTop}/>
    <Route path="ratings/:ratingSlug/edit" component={Rating} onEnter={scrollTop}/>
  </Route>

module.exports = routes
