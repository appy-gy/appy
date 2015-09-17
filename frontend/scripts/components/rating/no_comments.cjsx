React = require 'react'

NoComments = React.createClass
  displayName: 'NoComments'

  render: ->
    <div className="comments_empty">
      Вы будете первым
    </div>

module.exports = NoComments
