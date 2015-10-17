ReduxRouter = require 'redux-router'
history = require 'history'
routes = require './routes'

{reduxReactRouter} = ReduxRouter
{createHistory} = history

router = reduxReactRouter { routes, createHistory }

module.exports = router
