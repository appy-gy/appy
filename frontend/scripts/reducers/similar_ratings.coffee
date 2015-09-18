_ = require 'lodash'
ReduxActions = require 'redux-actions'
itemsReceiver = require '../helpers/reducers/items_receiver'
cleaner = require '../helpers/reducers/cleaner'

{handleActions} = ReduxActions

{defaultState, handlers} = itemsReceiver 'similarRatings'

handlers = _.merge handlers, cleaner('similarRatings', defaultState)

reducer = handleActions handlers, defaultState()

module.exports = reducer
