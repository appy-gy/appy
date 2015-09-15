ReduxActions = require 'redux-actions'
itemReceiver = require '../helpers/reducers/item_receiver'

{handleActions} = ReduxActions

{defaultState, handlers} = itemReceiver name: 'section'

reducer = handleActions handlers, defaultState()

module.exports = reducer
