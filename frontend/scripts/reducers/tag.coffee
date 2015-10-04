_ = require 'lodash'
ReduxActions = require 'redux-actions'
itemReceiver = require '../helpers/reducers/item_receiver'
cleaner = require '../helpers/reducers/cleaner'

{handleActions} = ReduxActions

{defaultState, handlers} = itemReceiver 'tag'

handlers = _.merge handlers, cleaner('tag', defaultState)

reducer = handleActions handlers, defaultState()

module.exports = reducer
