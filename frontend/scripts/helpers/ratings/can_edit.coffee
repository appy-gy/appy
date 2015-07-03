canEdit = (user, rating) ->
  user.isLoggedIn() and rating? and rating.status != 'published' and rating.user.id == user.id

module.exports = canEdit
