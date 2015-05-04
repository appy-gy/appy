React = require 'react/addons'

{PropTypes} = React

ShareButton = React.createClass
  displayName: 'ShareButton'

  propTypes:
    type: PropTypes.string.isRequired
    text: PropTypes.string.isRequired

  render: ->
    {type, text} = @props

    <div className="rating_share-button m-#{type}">
      <div className="rating_share-icon"></div>
      <div className="rating_share-text">
        {text}
      </div>
    </div>

module.exports = ShareButton
