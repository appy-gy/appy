_ = require 'lodash'
React = require 'react'
ReactDOM = require 'react-dom'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
getStore = require './get_store'

{Provider} = ReactRedux
{ReduxRouter} = ReduxRouter

run = ->
  element = <Provider store={getStore()}>
    <ReduxRouter/>
  </Provider>

  ReactDOM.render element, document.querySelector('#page')

module.exports = ->
  return run() if _.includes ['interactive', 'complete'], document.readyState
  document.addEventListener 'DOMContentLoaded', run
