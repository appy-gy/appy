canComment = (currentUser, rating) ->
  currentUser.isLoggedIn() and rating.status == 'published'

module.exports = canComment
