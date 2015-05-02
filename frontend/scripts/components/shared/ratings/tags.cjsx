React = require 'react/addons'
Tag = require './tag'

{PropTypes} = React
{PureRenderMixin} = React.addons

Tags = React.createClass
  displayName: 'Tags'

  mixins: [PureRenderMixin]

  propTypes:
    tags: PropTypes.arrayOf(PropTypes.object).isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  tags: ->
    {tags} = @props

    tags.map (tag) ->
      <Tag key={tag.id} tag={tag}/>

  render: ->
    {block} = @context

    <div className="#{block}_tags tags">
      {@tags()}
    </div>

module.exports = Tags
