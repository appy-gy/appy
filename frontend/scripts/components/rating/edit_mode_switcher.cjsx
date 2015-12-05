React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
classNames = require 'classnames'

{PropTypes} = React

EditModeSwitcher = React.createClass
  displayName: 'EditModeSwitcher'

  mixins: [PureRendexMixin]

  propTypes:
    isActive: PropTypes.bool.isRequired
    onClick: PropTypes.func.isRequired

  render: ->
    {isActive, onClick} = @props

    text = if isActive then 'Просмотр' else 'Редактирование'

    <div className="edit-mode-switcher" onClick={onClick}>
      {text}
    </div>

module.exports = EditModeSwitcher
