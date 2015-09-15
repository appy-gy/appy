_ = require 'lodash'
Redux = require 'redux'
createLogger = require 'redux-logger'
thunk = require 'redux-thunk'

{createStore, applyMiddleware, combineReducers} = Redux

module.exports = (reducers, state) ->
  reducer = combineReducers reducers
  # TODO: return
  logger = createLogger logger: console, predicate: _.constant(process.env.TOP_ENV == 'development')
  createStoreWithMiddleware = applyMiddleware thunk, logger
  store = createStoreWithMiddleware(createStore)(reducer)
  createStoreWithMiddleware(createStore)(reducer, state)
