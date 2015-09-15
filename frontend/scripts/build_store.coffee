_ = require 'lodash'
Redux = require 'redux'
createLogger = require 'redux-logger'
thunk = require 'redux-thunk'

{createStore, applyMiddleware, combineReducers} = Redux

module.exports = (reducers, state) ->
  reducer = combineReducers reducers
  logger = createLogger logger: console, collapsed: true, predicate: _.constant(process.env.TOP_ENV == 'development')
  createStoreWithMiddleware = applyMiddleware thunk, logger
  store = createStoreWithMiddleware(createStore)(reducer)
  createStoreWithMiddleware(createStore)(reducer, state)
