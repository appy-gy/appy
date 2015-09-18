_ = require 'lodash'
Redux = require 'redux'
createLogger = require 'redux-logger'
thunk = require 'redux-thunk'

{createStore, applyMiddleware, combineReducers, compose} = Redux

module.exports = (reducers, router, state) ->
  reducer = combineReducers reducers
  logger = createLogger logger: console, collapsed: true, predicate: _.constant(process.env.TOP_ENV == 'development')
  middlewares = applyMiddleware thunk, logger
  compose(middlewares, router)(createStore)(reducer, state)
