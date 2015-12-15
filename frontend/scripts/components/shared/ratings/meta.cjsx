moment = require 'moment'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
Item = require './meta_item'

{PropTypes} = React

Meta = React.createClass
  displayName: 'Meta'

  mixins: [PureRendexMixin]

  propTypes:
    rating: PropTypes.object.isRequired
    commentsAnchor: PropTypes.string

  contextTypes:
    block: PropTypes.string.isRequired

  getDefaultProps: ->
    commentsAnchor: null

  render: ->
    {rating, commentsAnchor} = @props
    {block} = @context

    timestamp = moment(rating.publishedAt || rating.createdAt)

    <div className="#{block}_meta">
      <Item ref="likesCounter" icon="likes">
        {rating.likesCount}
      </Item>
      <Item icon="comments" anchor={commentsAnchor}>
        {rating.commentsCount}
      </Item>
      <Item>
        {timestamp.format('D MMMM YYYY')}
      </Item>
    </div>

module.exports = Meta
