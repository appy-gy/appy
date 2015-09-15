_ = require 'lodash'
ReduxActions = require 'redux-actions'
paginatedItemsReceiver = require '../helpers/reducers/paginated_items_receiver'

{handleActions} = ReduxActions

{defaultState, handlers} = paginatedItemsReceiver name: 'sectionRatings'

handlers = _.merge handlers,
  CLEAR_SECTION_RATINGS: ->
    defaultState()

reducer = handleActions handlers, defaultState()

module.exports = reducer
