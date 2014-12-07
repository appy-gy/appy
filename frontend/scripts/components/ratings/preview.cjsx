React = require 'react/addons'

RatingsPreview = React.createClass
  render: ->
    {rating} = @props

    <div className="list_item rating-preview">
      <img className="rating-preview_image" src="//placehold.it/300x200"/>
      <div className="rating-preview_infos">
        <span className="rating-preview_info like">82</span>
        <span className="rating-preview_info watches">514</span>
        <span className="rating-preview_info">{rating.createdAt.format('D MMMM YYYY')}</span>
      </div>
      <div className="rating-preview_section">{rating.section.name}:</div>
      <div className="rating-preview_title">{rating.title}</div>
      <div className="rating-preview_tags">
        <span className="rating-preview_tag">#Дизайн</span>
        <span className="rating-preview_tag">#БЭМ</span>
      </div>
    </div>

module.exports = RatingsPreview
