React = require 'react'

Nothing = React.createClass
  displayName: 'Nothing'

  render: ->
    <noscript className="g-hidden"></noscript>

module.exports = Nothing
