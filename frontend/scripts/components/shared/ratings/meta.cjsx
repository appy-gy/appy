React = require 'react/addons'

{PropTypes} = React

Meta = React.createClass
  displayName: 'Meta'

  contextTypes:
    block: PropTypes.string.isRequired
    rating: PropTypes.object.isRequired

  render: ->
    {block, rating} = @context

    <div className="#{block}_meta">
      <div className="#{block}_item ">
        <div className="#{block}_icon m-likes"></div>
        <div ref="likesCounter" className="#{block}_text">
          {rating.likesCount}
        </div>
      </div>
      <div className="#{block}_item">
        <div className="#{block}_icon m-comments"></div>
        <div className="#{block}_text">
          {rating.commentsCount}
        </div>
      </div>
      <div className="#{block}_item">
        <div className="#{block}_text">
          {rating.createdAt.format('D MMMM YYYY')}
        </div>
      </div>
    </div>

module.exports = Meta
