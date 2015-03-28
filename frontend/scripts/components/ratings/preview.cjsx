React = require 'react/addons'
Router = require 'react-router'
classNames = require 'classnames'
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
      <div className="meta preview_meta">
        <div className="meta_item preview_item like-counter">
          <div className="meta_icon preview_icon ion-heart"></div>
          <div className="meta_text preview_text">
            433
          </div>
        </div>
        <div className="meta_item preview_item comments-counter">
          <div className="meta_icon preview_icon ion-chatbubble"></div>
          <div className="meta_text preview_text">
            433
          </div>
        </div>
        <div className="meta_item preview_item date">
          <div className="meta_text preview_text">
            {rating.createdAt.format('D MMMM YYYY')}
          </div>
        </div>
      </div>
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
