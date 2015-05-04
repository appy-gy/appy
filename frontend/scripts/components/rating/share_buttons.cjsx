React = require 'react/addons'
ShareButton = require './share_button'

ShareButtons = React.createClass
  displayName: 'ShareButtons'

  types: ['facebook', 'google', 'twitter']

  texts:
    facebook: 'Нравится'
    google: 'Поделиться'
    twitter: 'Твитнуть'

  buttons: ->
    @types.map (type) =>
      <ShareButton key={type} type={type} text={@texts[type]}/>

  render: ->
    <div className="rating_share">
      {@buttons()}
    </div>

module.exports = ShareButtons
