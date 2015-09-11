_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
Router = require 'react-router'
store = require './store'
routes = require './routes'
rehydrate = require './rehydrate'

{Provider} = ReactRedux
{HistoryLocation} = Router

run = ->
  rehydrate()

  Router.run routes, HistoryLocation, (Handler, state) ->
    tree = <Provider store={store}>
      {-> <Handler {...state.params}/>}
    </Provider>

    React.render tree, document.querySelector('#page')

module.exports = ->
  return run() if _.includes ['interactive', 'complete'], document.readyState
  document.addEventListener 'DOMContentLoaded', run
