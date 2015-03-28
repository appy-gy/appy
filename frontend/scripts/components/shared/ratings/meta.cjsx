React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

Meta = React.createClass
  displayName: 'Meta'

  mixins: [PureRenderMixin]

  propTypes:
    rating: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  render: ->
    {rating, block} = @props

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
