React = require 'react/addons'
Router = require 'react-router'
Link = Router.Link

RatingsPreview = React.createClass
  render: ->
    {rating} = @props

    tags = rating.tags.map (tag) ->
      <span key={tag.id} className="rating_tag">#{tag.name}</span>

    <div className="rating">
      <div className="rating_meta">
        <div className="rating_meta-item like">
          <div className="rating_meta-item-icon ion-heart"></div>
          <div className="rating_meta-item-text">433</div>
        </div>
        <div className="rating_meta-item comments">
          <div className="rating_meta-item-icon ion-chatbubble"></div>
          <div className="rating_meta-item-text">433</div>
        </div>
        <div className="rating_meta-item date">
          <div className="rating_meta-item-text">{rating.createdAt.format('D MMMM YYYY')}</div>
        </div>
      </div>
      <div className="rating_image"></div>
      <div className="rating_section-name">{rating.section.name}</div>
      <Link to="rating" params={rating} className="rating_title">{rating.title}</Link>
      <div className="rating_tags">
        {tags}
      </div>
    </div>

module.exports = RatingsPreview
