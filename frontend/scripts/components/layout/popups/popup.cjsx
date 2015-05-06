React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

Popup = React.createClass
  displayName: 'Popup'

  mixins: [PureRenderMixin]

  propTypes:
    popup: PropTypes.node.isRequired

  render: ->
    {popup} = @props

    <div className="popups_popup">
      {popup.content}
    </div>

module.exports = Popup
