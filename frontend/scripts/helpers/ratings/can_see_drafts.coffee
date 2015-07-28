CanSeeDrafts = (currentUser, user) ->
  currentUser.isLoggedIn() and currentUser.id == user.id

module.exports = CanSeeDrafts
