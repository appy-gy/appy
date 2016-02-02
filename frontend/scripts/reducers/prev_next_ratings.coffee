_ = require 'lodash'
ReduxActions = require 'redux-actions'
itemsReceiver = require '../helpers/reducers/items_receiver'
cleaner = require '../helpers/reducers/cleaner'

{handleActions} = ReduxActions

{defaultState, handlers} = itemsReceiver 'prevNextRatings'

handlers = _.merge handlers, cleaner('prevNextRatings', defaultState)

reducer = handleActions handlers, defaultState()

module.exports = reducer
