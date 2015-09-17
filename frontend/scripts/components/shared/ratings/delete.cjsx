React = require 'react'
ReactRedux = require 'react-redux'
ratingActions = require '../../../actions/rating'
showConfirm = require '../../../helpers/popups/confirm'

{PropTypes} = React
{connect} = ReactRedux
{removeRating} = ratingActions

DeleteRating = React.createClass
  displayName: 'DeleteRating'

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired
    onDelete: PropTypes.func

  contextTypes:
    block: PropTypes.string.isRequired

  getDefaultProps: ->
    onDelete: ->

  showDeleteConfirmation: (event) ->
    {dispatch, rating, onDelete} = @props

    event.preventDefault()

    showConfirm dispatch,
      text: 'Вы уверены, что хотите удалить этот рейтинг?'
      onConfirm: -> dispatch(removeRating()).then(onDelete)
      cancelText: 'Не удалять'

  render: ->
    {block} = @context

    <div className="#{block}_delete-rating" onClick={@showDeleteConfirmation}></div>

module.exports = connect()(DeleteRating)
