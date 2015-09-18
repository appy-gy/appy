ReduxReactRouter = require 'redux-react-router'
history = require 'history'
routes = require './routes'

{reduxReactRouter} = ReduxReactRouter
{createHistory} = history

router = reduxReactRouter { routes, createHistory }

module.exports = router
