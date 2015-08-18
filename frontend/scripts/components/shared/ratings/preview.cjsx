_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
Meta = require './meta'
Tags = require './tags'
Delete = require './delete'
RatingLink = require '../links/rating'

{PropTypes} = React

Preview = React.createClass
  displayName: 'Preview'

  mixins: [Marty.createAppMixin()]

  propTypes:
    rating: PropTypes.object.isRequired
    imageSize: PropTypes.string.isRequired
    showDelete: PropTypes.bool
    mods: PropTypes.string

  childContextTypes:
    rating: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {rating} = @props

    { rating, block: 'preview' }

  getDefaultProps: ->
    showDelete: false
    mod: null

  sectionName: ->
    {rating} = @props

    return unless rating.section?

    rating.section.name

  title: ->
    {rating} = @props

    rating.title or "Ваш рейтинг от #{rating.createdAt.format('HH:MM DD.MM.YYYY')}"

  description: ->
    {rating} = @props

    _.trunc rating.description,
      length: 90
      separator: /,? +/

  showDeleteConfirmation: (event) ->
    {rating} = @props

    event.preventDefault()

    removePopup = => @app.popupsActions.remove popup
    popupProps =
      text: 'Вы уверены, что хотите удалить этот рейтинг?'
      onConfirm: =>
        @app.ratingsActions.remove rating.id
        removePopup()
      onCancel: removePopup
    popup = new Popup
      type: 'confirmation'
      content: <ConfirmationPopup {...popupProps}/>

    @app.popupsActions.append popup

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

    <RatingLink rating={rating} className={classes}>
      <Meta/>
      <div className="preview_image" style={imageStyles}></div>
      <div className="preview_content">
        {@deleteButton()}
        <div className="preview_section-name" style={sectionNameStyles}>
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
