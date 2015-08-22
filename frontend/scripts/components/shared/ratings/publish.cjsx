_ = require 'lodash'
Marty = require 'marty'
React = require 'react/addons'
classNames = require 'classnames'
ConfirmationPopup = require '../popups/confirmation'
Popup = require '../../../models/popup'
prepublishValidation = require '../../../helpers/ratings/prepublish_validation'

{PropTypes} = React

Publish = React.createClass
  displayName: 'Publish'

  mixins: [Marty.createAppMixin()]

  propTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  hasPublishErrors: ->
    {rating, ratingItems} = @props

    not _.isEmpty prepublishValidation(rating, ratingItems)

  publish: ->
    {rating} = @props

    return if @hasPublishErrors()

    @app.ratingsActions.update(rating.id, status: 'published')

  confirmPublish: ->
    return if @hasPublishErrors()

    removePopup = => @app.popupsActions.remove popup
    popupProps =
      text: 'Внимание! После публикации рейтинга вы не сможете больше его редактировать. Вы уверены, что хотите опубликовать этот рейтинг?'
      onConfirm: =>
        @publish()
        removePopup()
      onCancel: removePopup
      cancelText: 'Не публиковать'
    popup = new Popup
      type: 'publish'
      content: <ConfirmationPopup {...popupProps}/>

    @app.popupsActions.append popup

  render: ->
    {block} = @context

    classes = classNames "#{block}_publish-rating", 'm-disabled': @hasPublishErrors()

    <div className={classes} onClick={@confirmPublish}>
      Опубликовать
    </div>

module.exports = Publish
