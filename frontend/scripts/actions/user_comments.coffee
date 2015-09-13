ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestUserComments = createAction 'REQUEST_USER_COMMENTS'
receiveUserComments = createAction 'RECEIVE_USER_COMMENTS'
setUserCommentsPagesCount = createAction 'SET_USER_COMMENTS_PAGES_COUNT'

fetchUserComments = (userId, page) ->
  (dispatch, getState) ->
    dispatch requestUserComments()

    axios.get("users/#{userId}/comments", params: { page }).then ({data}) ->
      data.comments.each (comment) -> comment.page = page
      dispatch receiveUserComments(data.comments)
      dispatch setUserCommentsPagesCount(data.meta.pagesCount)

module.exports = { fetchUserComments }
