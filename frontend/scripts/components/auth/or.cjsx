React = require 'react/addons'

{PureRenderMixin} = React.addons

Or = React.createClass
  displayName: 'Or'

  mixins: [PureRenderMixin]

  render: ->
    <div className="auth-popup_or" data-text="или">
      &nbsp;
    </div>

module.exports = Or
