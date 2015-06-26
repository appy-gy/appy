canEdit = (user, rating) ->
  user.isLoggedIn() and rating?.user.id == user.id

module.exports = canEdit
