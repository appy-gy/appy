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
      <div className="#{block}_item like-counter">
        <div className="#{block}_icon ion-heart"></div>
        <div className="#{block}_text">
          433
        </div>
      </div>
      <div className="#{block}_item comments-counter">
        <div className="#{block}_icon ion-chatbubble"></div>
        <div className="#{block}_text">
          433
        </div>
      </div>
      <div className="#{block}_item date">
        <div className="#{block}_text">
          {rating.createdAt.format('D MMMM YYYY')}
        </div>
      </div>
    </div>

module.exports = Meta
