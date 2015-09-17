_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
Router = require 'react-router'
reducers = require '../helpers/reducers'
memcached = require '../helpers/memcached'
buildStore = require '../../frontend/scripts/build_store'
routes = require '../../frontend/scripts/routes'
http = require '../../frontend/scripts/helpers/http'

{Provider} = ReactRedux

rendersLimit = 10
cacheLifetime = 1 * 60 # 1 minute

module.exports = ->
  (req, res, next) ->
    rendersCount = 0
    store = buildStore reducers
    router = Router.create { location: req.url, routes }

    render = ->
      html = undefined
      promises = undefined

      router.run (Handler, state) ->
        element = <Provider store={store}>
          {-> <Handler {...state.params}/>}
        </Provider>

        {result: html, promises} = http.recordRequests ->
          React.renderToString element

      rendersCount += 1
      return html if _.isEmpty(promises) or rendersCount >= rendersLimit
      Promise.all(promises).then(render)

    render()
      .then (html) ->
        locals = body: html, state: JSON.stringify(store.getState())
        memcached.set req.url, locals, cacheLifetime, ->
          res.render 'index', locals
          next()
      .catch (error) ->
        console.error 'Failed to render', req.url, error
        res.status(500).render('500')
