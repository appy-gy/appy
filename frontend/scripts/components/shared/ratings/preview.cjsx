React = require 'react/addons'
classNames = require 'classnames'
Meta = require './meta'
Tags = require './tags'
RatingLink = require '../links/rating'

{PropTypes} = React

Preview = React.createClass
  displayName: 'Preview'

  propTypes:
    rating: PropTypes.object.isRequired
    imageSize: PropTypes.string.isRequired
    mods: PropTypes.string

  childContextTypes:
    rating: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {rating} = @props

    { rating, block: 'preview' }

  getDefaultProps: ->
    mod: null

  sectionName: ->
    {rating} = @props

    return unless rating.section?

    rating.section.name

  title: ->
    {rating} = @props

    rating.title or "Черновик-#{rating.createdAt}"

  description: ->
    {rating} = @props

    rating.description

  render: ->
    {rating, imageSize, mod} = @props

    classes = classNames 'preview', "m-#{mod}"

    imageStyles = {}
    if rating.image
      imageStyles.backgroundImage = "url(#{rating.imageUrl(imageSize)})"
    else
      imageStyles.backgroundColor = 'rgba(33, 172, 208, 1)'

    <RatingLink rating={rating} className={classes}>
      <Meta/>
      <div className="preview_image" style={imageStyles}></div>
      <div className="preview_content">
        <div className="preview_section-name">
          {@sectionName()}
        </div>
        <div className="preview_title">
          {@title()}
        </div>
        <div className="preview_description">
          {@description()}
        </div>
        <Tags tags={rating.tags}/>
      </div>
    </RatingLink>

module.exports = Preview
