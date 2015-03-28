React = require 'react/addons'
Router = require 'react-router'
classNames = require 'classnames'
Meta = require '../shared/ratings/meta'
Tags = require '../shared/ratings/tags'

{PropTypes} = React
{PureRenderMixin} = React.addons
{Link} = Router

Preview = React.createClass
  displayName: 'Preview'

  mixins: [PureRenderMixin]

  propTypes:
    rating: PropTypes.object.isRequired
    mods: PropTypes.string

  getDefaultProps: ->
    mod: null

  render: ->
    {rating, mod} = @props

    classes = classNames 'preview', "m-#{mod}"

    <div className={classes}>
      <Meta rating={rating} block="preview"/>
      <div className="preview_image"></div>
      <div className="preview_section-name">
        {rating.section.name}
      </div>
      <Link to="rating" params={ratingId: rating.id} className="preview_title">
        {rating.title}
      </Link>
      <Tags tags={rating.tags} block="preview"/>
    </div>

module.exports = Preview
