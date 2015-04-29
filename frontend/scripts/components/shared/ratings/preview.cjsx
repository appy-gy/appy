React = require 'react/addons'
Router = require 'react-router'
classNames = require 'classnames'
Meta = require './meta'
Tags = require './tags'

{PropTypes} = React
{Link} = Router

Preview = React.createClass
  displayName: 'Preview'

  propTypes:
    rating: PropTypes.object.isRequired
    mods: PropTypes.string

  childContextTypes:
    rating: PropTypes.object.isRequired

  getChildContext: ->
    {rating} = @props

    { rating }

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
      <Meta rating={rating} block="preview"/>
      <div className="preview_image"></div>
      <div className="preview_section-name">
        {@sectionName()}
      </div>
      <Link to="rating" params={ratingId: rating.id} className="preview_title">
        {@title()}
      </Link>
      <Tags tags={rating.tags} block="preview"/>
    </div>

module.exports = Preview
