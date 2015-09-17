React = require 'react'
classNames = require 'classnames'

{PropTypes} = React

Title = React.createClass
  displayName: 'TabTitle'

  propTypes:
    text: PropTypes.string.isRequired
    active: PropTypes.bool.isRequired
    onClick: PropTypes.func.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  render: ->
    {text, active, onClick} = @props
    {block} = @context

    classes = classNames "#{block}_tab-title", 'm-active': active

    <div className={classes} onClick={onClick}>
      {text}
    </div>

module.exports = Title
