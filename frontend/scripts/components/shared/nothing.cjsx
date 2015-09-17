React = require 'react/addons'

Nothing = React.createClass
  displayName: 'Nothing'

  render: ->
    <span className="g-hidden"></span>

module.exports = Nothing
