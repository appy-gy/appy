React = require 'react'
ReactRedux = require 'react-redux'
ratingActions = require '../../../actions/rating'
showConfirm = require '../../../helpers/popups/confirm'
ReduxRouter = require 'redux-router'

{PropTypes} = React
{connect} = ReactRedux
{removeRating} = ratingActions
{replaceState} = ReduxRouter

DeleteRating = React.createClass
  displayName: 'DeleteRating'

  propTypes:
    dispatch: PropTypes.func.isRequired
    children: PropTypes.node.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  redirectToProfile: ->
    {dispatch, currentUser} = @props

    dispatch replaceState(null, "/users/#{currentUser.slug}")

  confirmDelete: ->
    {dispatch} = @props

    showConfirm dispatch,
      text: 'Вы уверены, что хотите удалить этот рейтинг?'
      onConfirm: @deleteRating
      cancelText: 'Не удалять'

  deleteRating: ->
    {dispatch} = @props

    dispatch(removeRating()).then @redirectToProfile()

  render: ->
    {children} = @props
    {block} = @context

    <div className="#{block}_delete-rating" onClick={@confirmDelete}>
      {children}
    </div>

mapStateToProps = ({currentUser}) ->
  currentUser: currentUser.item

module.exports = connect(mapStateToProps)(DeleteRating)
