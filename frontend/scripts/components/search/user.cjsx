React = require 'react'
imageUrl = require '../../helpers/image_url'
UserLink = require '../shared/links/user'

User = ({user}) ->
  <UserLink user={user} className="search_result m-rating">
    <img className="search_result-image" src={imageUrl(user.avatar, 'normal')}/>
    <div className="search_result-title">
      {user.name}
    </div>
  </UserLink>

module.exports = User
