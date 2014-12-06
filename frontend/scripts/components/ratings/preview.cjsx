React = require 'react/addons'

RatingsPreview = React.createClass
  render: ->
    {rating} = @props

    <div className="list_item rating-preview">
      <img className="rating-preview_image" src="//placehold.it/300x200"/>
      <div className="rating-preview_infos">
        <div className="rating-preview_info like">82</div>
        <div className="rating-preview_info watches">514</div>
        <div className="rating-preview_info">{rating.createdAt.format('D MMMM YYYY')}</div>
      </div>
      <div className="rating-preview_section">{rating.section.name}:</div>
      <div className="rating-preview_title">{rating.title}</div>
      <div className="rating-preview_tags">
        <div className="tag">#Дизайн</div>
        <div className="tag">#БЭМ</div>
      </div>
    </div>

module.exports = RatingsPreview
