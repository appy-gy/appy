React = require 'react/addons'
Marty = require 'marty'
ConfirmationPopup = require '../popups/confirmation'
Popup = require '../../../models/popup'

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

    removePopup = => @app.popupsActions.remove popup
    popupProps =
      text: 'Вы уверены, что хотите удалить этот рейтинг?'
      onConfirm: =>
        @app.ratingsActions.remove rating.id
        removePopup()
        onDelete()
      onCancel: removePopup
    popup = new Popup <ConfirmationPopup {...popupProps}/>

    @app.popupsActions.append popup

  render: ->
    {block} = @context

    <div className="#{block}_delete" onClick={@showDeleteConfirmation}>
      Удалить
    </div>

module.exports = DeleteRating