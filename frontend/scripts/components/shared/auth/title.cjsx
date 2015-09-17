React = require 'react'

{PropTypes} = React

Title = React.createClass
  displayName: 'Title'

  propTypes:
    text: PropTypes.string.isRequired

  render: ->
    {text} = @props

    <div className="auth-popup_title">
      {text}
    </div>

module.exports = Title
