_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ratingActions = require '../../../actions/rating'
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

  publish: ->
    {dispatch} = @props

    dispatch(updateRating(status: 'published')).then ->
      showToast dispatch, 'Рейтинг опубликован', 'success'

  confirmPublish: ->
    {dispatch} = @props

    showConfirm dispatch,
      text: 'Внимание! После публикации рейтинга вы не сможете больше его редактировать. Вы уверены, что хотите опубликовать этот рейтинг?'
      onConfirm: @publish
      cancelText: 'Не публиковать'

  render: ->
    <span>
      Ура! Теперь вы можете <span className="rating-statusbar_publish-button" onClick={@confirmPublish}>опубликовать</span> свой рейтинг!
    </span>

module.exports = connect()(Publish)
