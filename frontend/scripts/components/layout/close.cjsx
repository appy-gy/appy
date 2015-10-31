React = require 'react'
OnEsc = require '../mixins/on_esc'

{PropTypes} = React

Close = React.createClass
  displayName: 'Close'

  mixins: [OnEsc]

  propTypes:
    onClose: PropTypes.func.isRequired

  componentWillMount: ->
    @onEsc @onClose

  onClose: ->
    @props.onClose()

  render: ->
    <div className="layout_close" onClick={@onClose}></div>

module.exports = Close
