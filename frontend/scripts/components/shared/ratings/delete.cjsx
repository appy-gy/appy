React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
ratingActions = require '../../../actions/rating'
showConfirm = require '../../../helpers/popups/confirm'

{PropTypes} = React
{connect} = ReactRedux
{removeRating} = ratingActions

DeleteRating = React.createClass
  displayName: 'DeleteRating'

  mixins: [PureRenderMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    children: PropTypes.node.isRequired
    rating: PropTypes.object.isRequired
    onDelete: PropTypes.func

  contextTypes:
    block: PropTypes.string.isRequired

  getDefaultProps: ->
    onDelete: ->

  confirmDelete: (event) ->
    {dispatch} = @props

    event.preventDefault()

    showConfirm dispatch,
      text: 'Вы уверены, что хотите удалить этот рейтинг?'
      onConfirm: @deleteRating
      cancelText: 'Не удалять'

  deleteRating: ->
    {dispatch, rating, onDelete} = @props

    dispatch(removeRating(rating.id)).then(onDelete)

  render: ->
    {children} = @props
    {block} = @context

    <div className="#{block}_delete-rating" onClick={@confirmDelete}>
      {children}
    </div>

module.exports = connect()(DeleteRating)
