ReduxActions = require 'redux-actions'
itemsReceiver = require '../helpers/reducers/items_receiver'

{handleActions} = ReduxActions

{defaultState, handlers} = itemsReceiver 'sections'

reducer = handleActions handlers, defaultState()

module.exports = reducer
