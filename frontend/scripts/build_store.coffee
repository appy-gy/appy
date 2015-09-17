_ = require 'lodash'
Redux = require 'redux'
ReduxReactRouter = require 'redux-react-router'
createLogger = require 'redux-logger'
thunk = require 'redux-thunk'
history = require 'history'
routes = require './routes'

{createStore, applyMiddleware, combineReducers, compose} = Redux
{reduxReactRouter} = ReduxReactRouter
{createHistory} = history

module.exports = (reducers, state) ->
  reducer = combineReducers reducers
  logger = createLogger logger: console, collapsed: true, predicate: _.constant(process.env.TOP_ENV == 'development')
  middlewares = applyMiddleware thunk, logger
  router = reduxReactRouter { routes, createHistory }
  compose(middlewares, router)(createStore)(reducer, state)
