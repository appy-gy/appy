React = require 'react'
imageUrl = require '../../../helpers/image_url'
ratingShortDescription = require '../../../helpers/ratings/short_description'
RatingLink = require '../../shared/links/rating'

Rating = ({rating}) ->
  imageStyles = backgroundImage: "url(#{imageUrl(rating.image, 'preview')})"

  <RatingLink rating={rating} className="search_result m-rating">
    <div className="search_result-image" style={imageStyles}></div>
    <div className="search_result-content">
      <div className="search_result-title">
        {rating.title}
      </div>
      <div className="search_result-description">
        {ratingShortDescription rating.description}
      </div>
    </div>
  </RatingLink>

module.exports = Rating
