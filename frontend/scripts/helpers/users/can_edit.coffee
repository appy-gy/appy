canEdit = (currentUser, user) ->
  currentUser.id? and currentUser.id == user.id

module.exports = canEdit
