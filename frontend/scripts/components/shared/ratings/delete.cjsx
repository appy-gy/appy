React = require 'react/addons'
Marty = require 'marty'
showConfirm = require '../../../helpers/popups/confirm'

{PropTypes} = React

DeleteRating = React.createClass
  displayName: 'DeleteRating'

  mixins: [Marty.createAppMixin()]

  propTypes:
    rating: PropTypes.object.isRequired
    onDelete: PropTypes.func

  contextTypes:
    block: PropTypes.string.isRequired

  getDefaultProps: ->
    onDelete: ->

  showDeleteConfirmation: (event) ->
    {rating, onDelete} = @props

    event.preventDefault()

    showConfirm @app,
      text: 'Вы уверены, что хотите удалить этот рейтинг?'
      onConfirm: =>
        @app.ratingsActions.remove rating.id
        onDelete()
      cancelText: 'Не удалять'

  render: ->
    {block} = @context

    <div className="#{block}_delete-rating" onClick={@showDeleteConfirmation}></div>

module.exports = DeleteRating
