_ = require 'lodash'
reducers = require './reducers'
router = require './router'
buildStore = require './build_store'

store = null

getStore = ->
  return store if store?

  state = JSON.parse(document.querySelector('#state').getAttribute('data-state') || '{}')
  # FIXME: this is a temp hack to workaround bug in redux-router,
  # also there are some checks for the query presence in mapStateToProps funcs
  # remove them too
  state = _.omit state, 'router'

  store = buildStore reducers, router, state

module.exports = getStore
