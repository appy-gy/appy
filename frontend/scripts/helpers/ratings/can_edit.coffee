canEdit = (currentUser, rating) ->
  currentUser.id? and rating.id? and ((rating.status != 'published' and rating.user.id == currentUser.id) or currentUser.role == 'admin')

module.exports = canEdit
