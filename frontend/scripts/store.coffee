_ = require 'lodash'
Redux = require 'redux'
createLogger = require 'redux-logger'
thunk = require 'redux-thunk'

{createStore, applyMiddleware, combineReducers} = Redux

reqReducers = require.context './reducers'
reducers = _ reqReducers.keys()
  .filter (path) -> not _.endsWith path, '.coffee'
  .transform ((result, path) -> result[_.camelCase(path.replace(/^\.\//, ''))] = reqReducers path), {}
  .value()

reducer = combineReducers reducers
logger = createLogger predicate: _.constant(process.env.TOP_ENV == 'development')
createStoreWithMiddleware = applyMiddleware thunk, logger
store = createStoreWithMiddleware(createStore)(reducer)

module.exports = store
