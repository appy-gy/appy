_ = require 'lodash'
React = require 'react/addons'
classNames = require 'classnames'
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
    {object, className} = @props
    {edit} = @state
    {description} = object

    return if edit

    classes = classNames 'description', className

    <h1 className={classes} onClick={@startEdit}>
      {description}
    </h1>

  descriptionEdit: ->
    {object, className} = @props
    {edit} = @state
    {description} = object

    return unless edit

    classes = classNames 'description', 'edit', className

    <div>
      <textarea autoFocus={true} className={classes} value={description} onChange={@changeDescription} placeholder="Введи описание рейтинга"></textarea>
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
