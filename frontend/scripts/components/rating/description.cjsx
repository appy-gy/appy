React = require 'react/addons'
isBlank = require '../../helpers/is_blank'

{PropTypes} = React
{PureRenderMixin} = React.addons

ObjectDescription = React.createClass
  displayName: 'Description'

  getInitialState: ->
    {object} = @props
    edit: isBlank(object.description)

  startEdit: ->
    @setState edit: true

  stopEdit: ->
    {object} = @props
    @setState edit: false unless isBlank(object.description)

  updateDescription: (event) ->
    {object, actionCreator} = @props
    actionCreator.change object.id, { description: event.target.value }

  saveDescription: ->
    {object, actionCreator} = @props
    actionCreator.update object.id, { description: object.description }
    @stopEdit()

  descriptionCommon: ->
    {description} = @props.object
    {edit} = @state

    return if edit

    <h1 className="rating_description" onClick={@startEdit}>
      {description}
    </h1>

  descriptionEditable: ->
    {description} = @props.object
    {edit} = @state

    return unless edit

    <div>
      <textarea autoFocus={true} className="rating_description edit" value={description} onChange={@updateDescription} placeholder="Введи описание рейтинга"></textarea>
      <div className="rating_description-buttons">
        <button className="rating_description-button accept" onClick={@saveDescription}>
          сохранить
        </button>
        <button className="rating_description-button cancel" onClick={@stopEdit}>
          отменить
        </button>
      </div>
    </div>

  render: ->
    <div className="rating_description-wrapper">
      {@descriptionCommon()}
      {@descriptionEditable()}
    </div>

module.exports = ObjectDescription
