_ = require 'lodash'
React = require 'react/addons'
isBlank = require '../../helpers/is_blank'

{PropTypes} = React

ObjectTitle = React.createClass
  displayName: 'Title'

  propTypes:
    object: PropTypes.object.isRequired
    actionCreator: PropTypes.object.isRequired

  getInitialState: ->
    {object} = @props

    edit: isBlank(object.title)

  classes: ->
    {classes} = @props
    classes || ''

  startEdit: ->
    @setState edit: true

  stopEdit: ->
    {object} = @props

    @setState edit: false unless isBlank(object.title)

  changeTitle: (event) ->
    {object, actionCreator} = @props

    actionCreator.change object, title: event.target.value

  updateTitle: ->
    {object, actionCreator} = @props

    actionCreator.save object, title: object.title
    @stopEdit()

  titleView: ->
    {title} = @props.object
    {edit} = @state

    return if edit

    <h1 className={"title " + @classes()} onClick={@startEdit}>
      {title}
    </h1>

  titleEdit: ->
    {title} = @props.object
    {edit} = @state

    return unless edit

    <div>
      <textarea autoFocus={true} maxLength="50" className={"title edit " + @classes()} value={title} onChange={@changeTitle} placeholder="Введи заголовок рейтинга"></textarea>
      <div className="title-buttons">
        <button className="title-button accept" onClick={@updateTitle}>
          сохранить
        </button>
        <button className="title-button cancel" onClick={@stopEdit}>
          отменить
        </button>
      </div>
    </div>

  render: ->
    <div className="title-wrapper">
      {@titleView()}
      {@titleEdit()}
    </div>

module.exports = ObjectTitle
