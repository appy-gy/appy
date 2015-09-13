_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingActions = require '../../../actions/rating'
prepublishValidation = require '../../../helpers/ratings/prepublish_validation'
showConfirm = require '../../../helpers/popups/confirm'
showToast = require '../../../helpers/toasts/show'

{PropTypes} = React
{connect} = ReactRedux
{updateRating} = ratingActions

Publish = React.createClass
  displayName: 'Publish'

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  hasPublishErrors: ->
    {rating, ratingItems} = @props

    not _.isEmpty prepublishValidation(rating, ratingItems)

  publish: ->
    {dispatch, rating} = @props

    return if @hasPublishErrors()

    dispatch updateRating(status: 'published').then ->
      showToast dispatch, 'Рейтинг опубликован', 'success'

  confirmPublish: ->
    {dispatch} = @props

    return if @hasPublishErrors()

    showConfirm dispatch,
      text: 'Внимание! После публикации рейтинга вы не сможете больше его редактировать. Вы уверены, что хотите опубликовать этот рейтинг?'
      onConfirm: @publish
      cancelText: 'Не публиковать'

  render: ->
    {block} = @context

    classes = classNames "#{block}_publish-rating", 'm-disabled': @hasPublishErrors()

    <div className={classes} onClick={@confirmPublish}>
      Опубликовать
    </div>

module.exports = connect()(Publish)
