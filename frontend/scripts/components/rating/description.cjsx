_ = require 'lodash'
React = require 'react/addons'
isBlank = require '../../helpers/is_blank'

{PropTypes} = React

ObjectDescription = React.createClass
  displayName: 'Description'

  propTypes:
    object: PropTypes.object.isRequired
    actionCreator: PropTypes.object.isRequired

  getInitialState: ->
    {object} = @props

    edit: isBlank(object.description)

  classes: ->
    {classes} = @props
    classes || ''

  startEdit: ->
    @setState edit: true

  stopEdit: ->
    {object} = @props

    @setState edit: false unless isBlank(object.description)

  changeDescription: (event) ->
    {object, actionCreator} = @props

    actionCreator.change object, description: event.target.value

  updateDescription: ->
    {object, actionCreator} = @props

    actionCreator.save object, description: object.description
    @stopEdit()

  descriptionView: ->
    {description} = @props.object
    {edit} = @state

    return if edit

    <h1 className={"description " + @classes()} onClick={@startEdit}>
      {description}
    </h1>

  descriptionEdit: ->
    {description} = @props.object
    {edit} = @state

    return unless edit

    <div>
      <textarea autoFocus={true} className={"description edit " + @classes()} value={description} onChange={@changeDescription} placeholder="Введи описание рейтинга"></textarea>
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
      {@descriptionView()}
      {@descriptionEdit()}
    </div>

module.exports = ObjectDescription
