_ = require 'lodash'
React = require 'react'
ReactDOM = require 'react-dom/server'
ReactRedux = require 'react-redux'
ReduxReactRouter = require 'redux-react-router'
ReduxReactRouterServer = require 'redux-react-router/server'
Helmet = require 'react-helmet'
he = require 'he'
reducers = require '../helpers/reducers'
router = require '../helpers/router'
memcached = require '../helpers/memcached'
buildStore = require '../../frontend/scripts/build_store'
http = require '../../frontend/scripts/helpers/http'

{Provider} = ReactRedux
{ReduxRouter} = ReduxReactRouter
{match} = ReduxReactRouterServer

rendersLimit = 10
cacheLifetime = 1 * 60 # 1 minute

module.exports = ->
  (req, res, next) ->
    rendersCount = 0
    store = buildStore reducers, router

    render = ->
      element = <Provider store={store}>
        <ReduxRouter/>
      </Provider>

      {result: body, promises} = http.recordRequests ->
        ReactDOM.renderToString element
      head = Helmet.rewind()

      rendersCount += 1
      return { head, body } if _.isEmpty(promises) or rendersCount >= rendersLimit
      Promise.all(promises).then(render)

    onMatch = ->
      render()
        .then ({head, body}) ->
          head = _.mapValues head, (content) -> he.decode(content).replace(/(content="(?:.*?))"((?:.*?)")/g, '$1&quot;$2')
          locals = { head, body, state: JSON.stringify(store.getState()) }
          memcached.set req.url, locals, cacheLifetime, ->
            res.render 'index', locals
            next()
        .catch (error) ->
          console.error 'Failed to render', req.url, error, error.stack
          res.status(500).render('500')

    store.dispatch match(req.url, onMatch)
