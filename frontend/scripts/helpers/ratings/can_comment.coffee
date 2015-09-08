canComment = (currentUser, rating) ->
  currentUser.id? and rating.status == 'published'

module.exports = canComment
