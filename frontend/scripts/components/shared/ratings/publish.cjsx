_ = require 'lodash'
Marty = require 'marty'
React = require 'react/addons'
classNames = require 'classnames'
prepublishValidation = require '../../../helpers/ratings/prepublish_validation'
showConfirm = require '../../../helpers/popups/confirm'
showToast = require '../../../helpers/toasts/show'

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

    @app.ratingsActions.update(rating.id, status: 'published').then =>
      showToast @app, 'Рейтинг опубликован', 'success'

  confirmPublish: ->
    return if @hasPublishErrors()

    showConfirm @app,
      text: 'Внимание! После публикации рейтинга вы не сможете больше его редактировать. Вы уверены, что хотите опубликовать этот рейтинг?'
      onConfirm: @publish
      cancelText: 'Не публиковать'

  render: ->
    {block} = @context

    classes = classNames "#{block}_publish-rating", 'm-disabled': @hasPublishErrors()

    <div className={classes} onClick={@confirmPublish}>
      Опубликовать
    </div>

module.exports = Publish
