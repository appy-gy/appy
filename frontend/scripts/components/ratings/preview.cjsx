React = require 'react/addons'

RatingsPreview = React.createClass
  render: ->
    {rating} = @props

    <div>
      <div>{rating.title}</div>
      <div>{rating.createdAt}</div>
    </div>

module.exports = RatingsPreview
