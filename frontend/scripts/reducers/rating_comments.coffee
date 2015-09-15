_ = require 'lodash'
React = require 'react/addons'
ReduxActions = require 'redux-actions'
itemsReceiver = require '../helpers/reducers/items_receiver'

{update} = React.addons
{handleActions} = ReduxActions

{defaultState, handlers} = itemsReceiver name: 'ratingComments'

handlers = _.merge handlers,
  APPEND_RATING_COMMENT: (state, {payload: comment}) ->
    update state, items: { $push: [comment] }

reducer = handleActions handlers, defaultState()

module.exports = reducer
