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

  render: ->
    {rating, mod} = @props

    classes = classNames 'preview', "m-#{mod}"

    <div className={classes}>
      <Meta/>
      <div className="preview_image" style={backgroundImage: "url(#{rating.imageUrl('small')})"}></div>
      <div className="preview_section-name">
        {@sectionName()}
      </div>
      <RatingLink className="preview_title" rating={rating}>
        {@title()}
      </RatingLink>
      <Tags tags={rating.tags}/>
    </div>

module.exports = Preview
