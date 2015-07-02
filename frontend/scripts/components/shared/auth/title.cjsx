React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

Title = React.createClass
  displayName: 'Title'

  mixins: [PureRenderMixin]

  propTypes:
    text: PropTypes.string.isRequired

  render: ->
    {text} = @props

    <div className="auth-popup_title">
      {text}
    </div>

module.exports = Title
