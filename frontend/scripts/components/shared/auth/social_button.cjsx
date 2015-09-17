React = require 'react'
classNames = require 'classnames'

{PropTypes} = React

SocialButton = React.createClass
  displayName: 'SocialButton'

  propTypes:
    provider: PropTypes.string.isRequired
    text: PropTypes.string.isRequired
    onClick: PropTypes.func.isRequired

  render: ->
    {provider, text, onClick} = @props

    classes = classNames 'auth-popup_social-button', "m-#{provider}"

    <div className={classes} onClick={onClick}>
      {text}
    </div>

module.exports = SocialButton
