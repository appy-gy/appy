_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
Meta = require './meta'
Tags = require './tags'
Delete = require './delete'
RatingLink = require '../links/rating'
SectionLink = require '../links/section'

{PropTypes} = React

Preview = React.createClass
  displayName: 'Preview'

  mixins: [Marty.createAppMixin()]

  propTypes:
    rating: PropTypes.object.isRequired
    imageSize: PropTypes.string.isRequired
    showDelete: PropTypes.bool
    mod: PropTypes.string

  childContextTypes:
    rating: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {rating} = @props

    { rating, block: 'preview' }

  getDefaultProps: ->
    showDelete: false
    mod: null

  title: ->
    {rating} = @props

    rating.title or "Ваш рейтинг от #{rating.createdAt.format('HH:MM DD.MM.YYYY')}"

  description: ->
    {rating} = @props

    _.trunc rating.description,
      length: 90
      separator: /,? +/

  deleteButton: ->
    {rating, showDelete} = @props

    return unless showDelete

    <Delete rating={rating}/>

  render: ->
    {rating, imageSize, mod} = @props

    classes = classNames 'preview', "m-#{mod}"

    imageStyles = {}
    if rating.image
      imageStyles.backgroundImage = "url(#{rating.imageUrl(imageSize)})"
    else
      imageStyles.backgroundColor = 'rgba(33, 172, 208, 1)'

    sectionNameStyles = _.pick rating.section, 'color'

    <div className={classes}>
      <Meta/>
      <RatingLink rating={rating}>
        <div className="preview_image" style={imageStyles}></div>
      </RatingLink>
      <div className="preview_content">
        {@deleteButton()}
        <SectionLink className="preview_section-name" section={rating.section} style={sectionNameStyles}>
          {rating.section?.name}
        </SectionLink>
        <RatingLink rating={rating}>
          <div className="preview_title">
            {@title()}
          </div>
          <div className="preview_description">
            {@description()}
          </div>
          <Tags tags={rating.tags}/>
        </RatingLink>
      </div>
    </div>

module.exports = Preview
