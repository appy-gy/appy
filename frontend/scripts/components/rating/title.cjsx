_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Textarea = require 'react-textarea-autosize'
Classes = require '../mixins/classes'
isBlank = require '../../helpers/is_blank'
withIndexKeys = require '../../helpers/react/with_index_keys'

{PropTypes} = React

ObjectTitle = React.createClass
  displayName: 'Title'

  mixins: [Marty.createAppMixin(), Classes]

  propTypes:
    object: PropTypes.object.isRequired
    actions: PropTypes.string.isRequired

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
    {object, actions} = @props

    @app[actions].change object.id, title: event.target.value

  updateTitle: ->
    {object, actions} = @props

    @app[actions].update object.id, title: object.title
    @stopEdit()

  titleView: ->
    {object, className} = @props
    {edit} = @state
    {block} = @context
    {title} = object

    return if edit

    <h1 className={@classes("#{block}_title")} onClick={@startEdit}>
      {title}
    </h1>

  titleEdit: ->
    {object, className} = @props
    {edit} = @state
    {block} = @context
    {title} = object

    return unless edit

    withIndexKeys [
      <Textarea autoFocus={true} maxLength="50" className={@classes("#{block}_title", 'm-edit')} value={title} onChange={@changeTitle} placeholder="Введи заголовок рейтинга"></Textarea>
      <div className="#{block}_title-buttons">
        <button className="#{block}_title-button m-accept" onClick={@updateTitle}>
          сохранить
        </button>
        <button className="#{block}_title-button m-cancel" onClick={@stopEdit}>
          отменить
        </button>
      </div>
    ]

  render: ->
    {block} = @context

    <div className="#{block}_title-wrapper">
      {@titleView()}
      {@titleEdit()}
    </div>

module.exports = ObjectTitle
