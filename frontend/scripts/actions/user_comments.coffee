ReduxActions = require 'redux-actions'
paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{createAction} = ReduxActions

{fetch: fetchUserComments} = paginatedItemsFetcher
  name: 'userComments'
  url: ({args}) -> "users/#{args[0]}/comments"
  responseKey: 'comments'
  getPage: (args) -> args[1]

module.exports = { fetchUserComments }
