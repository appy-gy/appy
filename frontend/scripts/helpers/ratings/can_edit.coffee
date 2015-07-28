canEdit = (currentUser, rating) ->
  currentUser.isLoggedIn() and rating? and rating.status != 'published' and rating.user.id == currentUser.id

module.exports = canEdit
