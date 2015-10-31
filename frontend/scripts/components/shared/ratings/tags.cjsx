React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
Tag = require './tag'

{PropTypes} = React

Tags = React.createClass
  displayName: 'Tags'

  mixins: [PureRendexMixin]

  propTypes:
    rating: PropTypes.object.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  tags: ->
    {rating} = @props

    rating.tags.map (tag) ->
      <Tag key={tag.id} tag={tag}/>

  render: ->
    {block} = @context

    <div className="#{block}_tags tags">
      {@tags()}
    </div>

module.exports = Tags
