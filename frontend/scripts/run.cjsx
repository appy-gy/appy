_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
Router = require 'react-router'
reducers = require './reducers'
buildStore = require './build_store'
routes = require './routes'

{Provider} = ReactRedux
{HistoryLocation} = Router

run = ->
  state = JSON.parse(document.querySelector('#state').getAttribute('data-state') || '{}')
  store = buildStore reducers, state

  Router.run routes, HistoryLocation, (Handler, state) ->
    element = <Provider store={store}>
      {-> <Handler {...state.params}/>}
    </Provider>

    React.render element, document.querySelector('#page')

module.exports = ->
  return run() if _.includes ['interactive', 'complete'], document.readyState
  document.addEventListener 'DOMContentLoaded', run
