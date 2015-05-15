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

  contextTypes:
    block: PropTypes.string.isRequired

  getInitialState: ->
    {object} = @props

    edit: isBlank(object.title)

  startEdit: ->
    {object} = @props

    return unless object.canEdit
    @setState edit: true

  stopEdit: ->
    {object} = @props

    @setState edit: false unless isBlank(object.title)

  changeTitle: (event) ->
    {object, actionCreator} = @props

    actionCreator.change object.id, title: event.target.value

  updateTitle: ->
    {object, actionCreator} = @props

    actionCreator.update object.id, title: object.title
    @stopEdit()

  titleView: ->
    {object, className} = @props
    {edit} = @state
    {block} = @context
    {title} = object

    return if edit

    classes = classNames "#{block}_title", className

    <h1 className={classes} onClick={@startEdit}>
      {title}
    </h1>

  titleEdit: ->
    {object, className} = @props
    {edit} = @state
    {block} = @context
    {title} = object

    return unless edit

    classes = classNames "#{block}_title", 'm-edit', className

    <div>
      <textarea autoFocus={true} maxLength="50" className={classes} value={title} onChange={@changeTitle} placeholder="Введи заголовок рейтинга"></textarea>
      <div className="#{block}_title-buttons">
        <button className="#{block}_title-button m-accept" onClick={@updateTitle}>
          сохранить
        </button>
        <button className="#{block}_title-button m-cancel" onClick={@stopEdit}>
          отменить
        </button>
      </div>
    </div>

  render: ->
    <div>
      {@titleView()}
      {@titleEdit()}
    </div>

module.exports = ObjectTitle
