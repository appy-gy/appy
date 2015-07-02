React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

Close = React.createClass
  displayName: 'Close'

  mixins: [PureRenderMixin]

  propTypes:
    onClick: PropTypes.func.isRequired

  render: ->
    {onClick} = @props

    <div className="auth-popup_close" onClick={onClick}></div>

module.exports = Close
