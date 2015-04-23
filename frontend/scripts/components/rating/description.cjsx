_ = require 'lodash'
React = require 'react/addons'
isBlank = require '../../helpers/is_blank'

{PropTypes} = React

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

  changeDescription: (event) ->
    {object, actionCreator} = @props
    actionCreator.change object.id, description: event.target.value

  updateDescription: ->
    {object, actionCreator, parentId} = @props
    args = _.compact [object.id, parentId]
    actionCreator.update args..., description: object.description
    @stopEdit()

  descriptionCommon: ->
    {description} = @props.object
    {edit} = @state

    return if edit

    <h1 className="description" onClick={@startEdit}>
      {description}
    </h1>

  descriptionEditable: ->
    {description} = @props.object
    {edit} = @state

    return unless edit

    <div>
      <textarea autoFocus={true} className="description edit" value={description} onChange={@changeDescription} placeholder="Введи описание рейтинга"></textarea>
      <div className="description-buttons">
        <button className="description-button accept" onClick={@updateDescription}>
          сохранить
        </button>
        <button className="description-button cancel" onClick={@stopEdit}>
          отменить
        </button>
      </div>
    </div>

  render: ->
    <div className="description-wrapper">
      {@descriptionCommon()}
      {@descriptionEditable()}
    </div>

module.exports = ObjectDescription
