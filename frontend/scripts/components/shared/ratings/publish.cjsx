_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ratingActions = require '../../../actions/rating'
classNames = require 'classnames'
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
    {status} = @props

    classes = classNames 'm-disabled': status != 'done'

    <span>
      Ура! Теперь вы можете <span className="rating-statusbar_publish-button #{classes}" onClick={@confirmPublish}>опубликовать</span> свой рейтинг!
    </span>

mapStateToProps = ({rating}) ->
  status: rating.updateStatus

module.exports = connect(mapStateToProps)(Publish)
