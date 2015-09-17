_ = require 'lodash'
React = require 'react'

{PropTypes} = React

ShowMore = React.createClass
  displayName: 'ShowMore'

  propTypes:
    onClick: PropTypes.func.isRequired

  render: ->
    {onClick} = @props

    <div className="previews_show-more-wrap">
      <div className="previews_show-more" onClick={onClick}>
        <div className="previews_show-more-icon">
        </div>
        <div className="previews_show-more-text">
          Хочу еще больше
        </div>
      </div>
    </div>

module.exports = ShowMore
