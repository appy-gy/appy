_ = require 'lodash'
React = require 'react'
ReactDOM = require 'react-dom'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
reducers = require './reducers'
router = require './router'
buildStore = require './build_store'

{Provider} = ReactRedux
{ReduxRouter} = ReduxRouter

run = ->
  state = JSON.parse(document.querySelector('#state').getAttribute('data-state') || '{}')
  # TODO: this is a temp hack to workaround bug in redux-router,
  # also there are some checks for the query presence in mapStateToProps funcs
  # remove them too
  state = _.omit state, 'router'
  store = buildStore reducers, router, state

  element = <Provider store={store}>
    <ReduxRouter/>
  </Provider>

  ReactDOM.render element, document.querySelector('#page')

module.exports = ->
  return run() if _.includes ['interactive', 'complete'], document.readyState
  document.addEventListener 'DOMContentLoaded', run
