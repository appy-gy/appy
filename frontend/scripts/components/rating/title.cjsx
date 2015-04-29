_ = require 'lodash'
React = require 'react/addons'
classNames = require 'classnames'
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
    {object, className} = @props
    {edit} = @state
    {title} = object

    return if edit

    classes = classNames 'title', className

    <h1 className={classes} onClick={@startEdit}>
      {title}
    </h1>

  titleEdit: ->
    {object, className} = @props
    {edit} = @state
    {title} = object

    return unless edit

    classes = classNames 'title', 'edit', className

    <div>
      <textarea autoFocus={true} maxLength="50" className={classes} value={title} onChange={@changeTitle} placeholder="Введи заголовок рейтинга"></textarea>
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
