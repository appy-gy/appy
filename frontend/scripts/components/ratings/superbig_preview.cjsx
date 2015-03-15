React = require 'react/addons'
Router = require 'react-router'
Link = Router.Link

RatingsSuperbigPreview = React.createClass
  render: ->
    {rating} = @props

    tags = rating.tags.map (tag) ->
      <span key={tag.id} className="tag rating-tag">#{tag.name}</span>

    <div className="preview superbig">
      <div className="meta preview_meta">
        <div className="meta_item preview_item like-counter">
          <div className="meta_icon preview_icon ion-heart"></div>
          <div className="meta_text preview_text">433</div>
        </div>
        <div className="meta_item preview_item comments-counter">
          <div className="meta_icon preview_icon ion-chatbubble"></div>
          <div className="meta_text preview_text">433</div>
        </div>
        <div className="meta_item preview_item date">
          <div className="meta_text preview_text">{rating.createdAt.format('D MMMM YYYY')}</div>
        </div>
      </div>
      <div className="preview_image"></div>
      <div className="preview_section-name">{rating.section.name}</div>
      <Link to="rating" params={rating} className="preview_title">{rating.title}</Link>
      <div className="preview_tags tags">
        {tags}
      </div>
    </div>

module.exports = RatingsSuperbigPreview