_ = require 'lodash'
React = require 'react/addons'
ReactDOM = require 'react-dom'
ReactRedux = require 'react-redux'
ReduxReactRouter = require 'redux-react-router'
reducers = require './reducers'
buildStore = require './build_store'

{Provider} = ReactRedux
{ReduxRouter} = ReduxReactRouter

run = ->
  state = JSON.parse(document.querySelector('#state').getAttribute('data-state') || '{}')
  store = buildStore reducers, state

  element = <Provider store={store}>
    <ReduxRouter/>
  </Provider>

  ReactDOM.render element, document.querySelector('#page')

module.exports = ->
  return run() if _.includes ['interactive', 'complete'], document.readyState
  document.addEventListener 'DOMContentLoaded', run
