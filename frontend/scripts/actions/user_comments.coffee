ReduxActions = require 'redux-actions'
paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{createAction} = ReduxActions

clearUserComments = createAction 'CLEAR_USER_COMMENTS'

{fetch: fetchUserComments} = paginatedItemsFetcher
  name: 'userComments'
  url: (page, userId) -> "users/#{userId}/comments"
  responseKey: 'comments'

module.exports = { fetchUserComments, clearUserComments }
