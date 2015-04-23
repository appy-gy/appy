React = require 'react/addons'

{PropTypes} = React

Meta = React.createClass
  displayName: 'Meta'

  propTypes:
    block: PropTypes.string.isRequired

  contextTypes:
    rating: PropTypes.object.isRequired

  render: ->
    {block} = @props
    {rating} = @context

    <div className="#{block}_meta">
      <div className="#{block}_item ">
        <div className="#{block}_icon m-likes"></div>
        <div className="#{block}_text">
          433
        </div>
      </div>
      <div className="#{block}_item">
        <div className="#{block}_icon m-comments"></div>
        <div className="#{block}_text">
          433
        </div>
      </div>
      <div className="#{block}_item">
        <div className="#{block}_text">
          {rating.createdAt.format('D MMMM YYYY')}
        </div>
      </div>
    </div>

module.exports = Meta
