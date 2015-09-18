_ = require 'lodash'
update = require 'react-addons-update'
ReduxActions = require 'redux-actions'
itemsReceiver = require '../helpers/reducers/items_receiver'
cleaner = require '../helpers/reducers/cleaner'

{handleActions} = ReduxActions

{defaultState, handlers} = itemsReceiver 'ratingComments'

handlers = _.merge handlers, cleaner('ratingComments', defaultState),
  APPEND_RATING_COMMENT: (state, {payload: comment}) ->
    update state, items: { $push: [comment] }

reducer = handleActions handlers, defaultState()

module.exports = reducer
