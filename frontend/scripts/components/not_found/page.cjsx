React = require 'react/addons'

NotFoundPage = React.createClass
  displayName: 'NotFoundPage'

  render: ->
    <div className="not-found">
      404
    </div>

module.exports = NotFoundPage
