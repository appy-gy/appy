_ = require 'lodash'
update = require 'react-addons-update'
ReduxActions = require 'redux-actions'
itemsReceiver = require '../helpers/reducers/items_receiver'
cleaner = require '../helpers/reducers/cleaner'

{handleActions} = ReduxActions

{defaultState, handlers} = itemsReceiver 'ratingComments'

defaultState = _.backflow defaultState, ->
  visibleCommentForm: null

handlers = _.merge handlers, cleaner('ratingComments', defaultState),
  APPEND_RATING_COMMENT: (state, {payload: comment}) ->
    update state, items: { $push: [comment] }

  CHANGE_COMMENT_FORM_VISIBILITY: (state, {payload: id}) ->
    update state, visibleCommentForm: { $set: id }

reducer = handleActions handlers, defaultState()

module.exports = reducer
