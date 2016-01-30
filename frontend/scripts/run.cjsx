_ = require 'lodash'
React = require 'react'
ReactDOM = require 'react-dom'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
getStore = require './get_store'

{Provider} = ReactRedux
{ReduxRouter} = ReduxRouter

run = ->
  getStore().then (store) ->
    element = <Provider store={store}>
      <ReduxRouter/>
    </Provider>

    ReactDOM.render element, document.querySelector('#page')

module.exports = run
