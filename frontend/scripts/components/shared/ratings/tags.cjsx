React = require 'react/addons'
Tag = require './tag'

{PropTypes} = React

Tags = React.createClass
  displayName: 'Tags'

  contextTypes:
    rating: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  tags: ->
    {rating} = @context

    rating.tags.map (tag) ->
      <Tag key={tag.id} tag={tag}/>

  render: ->
    {block} = @context

    <div className="#{block}_tags tags">
      {@tags()}
    </div>

module.exports = Tags
