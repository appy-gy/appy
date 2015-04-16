React = require 'react/addons'
isBlank = require '../../helpers/is_blank'

{PropTypes} = React
{PureRenderMixin} = React.addons

ObjectTitle = React.createClass
  displayName: "Title"

  getInitialState: ->
    {object} = @props
    edit: isBlank(object.title)

  startEdit: ->
    @setState edit: true

  stopEdit: ->
    {object} = @props
    @setState edit: false unless isBlank(object.title)

  updateTitle: (event) ->
    {object, actionCreator} = @props
    console.log object
    actionCreator.change object.id, { title: event.target.value }

  saveTitle: ->
    {object, actionCreator} = @props
    actionCreator.update object.id, { title: object.title }
    @stopEdit()

  titleCommon: ->
    {title} = @props.object
    {edit} = @state

    return if edit

    <h1 className="rating_title" onClick={@startEdit}>
      {title}
    </h1>

  titleEditable: ->
    {title} = @props.object
    {edit} = @state

    return unless edit

    <div>
      <textarea autoFocus={true} maxLength="50" className="rating_title edit" value={title} onChange={@updateTitle} placeholder="Введи заголовок рейтинга"></textarea>
      <div className="rating_title-buttons">
        <button className="rating_title-button accept" onClick={@saveTitle}>
          сохранить
        </button>
        <button className="rating_title-button cancel" onClick={@stopEdit}>
          отменить
        </button>
      </div>
    </div>

  render: ->
    <div className="rating_title-wrapper">
      {@titleCommon()}
      {@titleEditable()}
    </div>

module.exports = ObjectTitle
