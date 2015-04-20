React = require 'react/addons'

{PureRenderMixin} = React.addons

Nothing = React.createClass
  displayName: 'Nothing'

  mixins: [PureRenderMixin]

  render: ->
    <span className="g-hidden"></span>

module.exports = Nothing
