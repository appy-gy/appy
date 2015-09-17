React = require 'react/addons'

Or = React.createClass
  displayName: 'Or'

  mixins: [PureRenderMixin]

  render: ->
    <div className="auth-popup_or">или</div>

module.exports = Or
