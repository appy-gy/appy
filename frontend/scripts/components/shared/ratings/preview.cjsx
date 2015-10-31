_ = require 'lodash'
moment = require 'moment'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
classNames = require 'classnames'
imageUrl = require '../../../helpers/image_url'
ratingShortDescription = require '../../../helpers/ratings/short_description'
Meta = require './meta'
Tags = require './tags'
Delete = require './delete'
RatingLink = require '../links/rating'
SectionLink = require '../links/section'

{PropTypes} = React

Preview = React.createClass
  displayName: 'Preview'

  mixins: [PureRendexMixin]

  propTypes:
    rating: PropTypes.object.isRequired
    imageSize: PropTypes.string.isRequired
    showDelete: PropTypes.bool
    mod: PropTypes.string

  childContextTypes:
    block: PropTypes.string.isRequired

  getChildContext: ->
    block: 'preview'

  getDefaultProps: ->
    showDelete: false
    mod: null

  title: ->
    {rating} = @props

    rating.title or "Ваш рейтинг от #{moment(rating.createdAt).format('HH:MM DD.MM.YYYY')}"

  deleteButton: ->
    {rating, showDelete} = @props

    return unless showDelete

    <Delete rating={rating}/>

  render: ->
    {rating, imageSize, mod} = @props

    classes = classNames 'preview', "m-#{mod}"

    imageStyles = {}
    if rating.image
      imageStyles.backgroundImage = "url(#{imageUrl rating.image, imageSize})"
    else
      imageStyles.backgroundColor = 'rgba(0, 0, 0, 1)'

    sectionNameStyles = _.pick rating.section, 'color'

    <div className={classes}>
      <Meta rating={rating}/>
      <RatingLink className="preview_image-wrap" rating={rating}>
        <div className="preview_image" style={imageStyles}></div>
        {@deleteButton()}
      </RatingLink>
      <div className="preview_content">
        <SectionLink className="preview_section-name" section={rating.section} style={sectionNameStyles}>
          {rating.section?.name}
        </SectionLink>
        <RatingLink className="preview_title" rating={rating}>
          {@title()}
        </RatingLink>
        <div className="preview_description">
          {ratingShortDescription rating.description}
        </div>
        <Tags rating={rating}/>
      </div>
    </div>

module.exports = Preview
