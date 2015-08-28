React = require 'react/addons'
Item = require './meta_item'

{PropTypes} = React

Meta = React.createClass
  displayName: 'Meta'

  contextTypes:
    block: PropTypes.string.isRequired
    rating: PropTypes.object.isRequired

  render: ->
    {block, rating} = @context

    timestamp = rating.publishedAt || rating.createdAt

    <div className="#{block}_meta">
      <Item ref="likesCounter" icon="likes">
        {rating.likesCount}
      </Item>
      <Item icon="comments">
        {rating.commentsCount}
      </Item>
      <Item icon="views">
        {rating.viewsCount}
      </Item>
      <Item>
        {timestamp?.format('D MMMM YYYY')}
      </Item>
    </div>

module.exports = Meta
