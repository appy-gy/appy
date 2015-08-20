_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
isBlank = require '../../helpers/is_blank'
withIndexKeys = require '../../helpers/react/with_index_keys'
Classes = require '../mixins/classes'
RatingUpdater = require '../mixins/rating_updater'
Textarea = require '../shared/inputs/text'

{PropTypes} = React

ObjectTitle = React.createClass
  displayName: 'Title'

  mixins: [Marty.createAppMixin(), Classes, RatingUpdater]

  propTypes:
    object: PropTypes.object.isRequired
    actions: PropTypes.string.isRequired
    placeholder: PropTypes.string.isRequired

  contextTypes:
    block: PropTypes.string.isRequired
    canEdit: PropTypes.bool.isRequired

  getInitialState: ->
    edit: false

  startEdit: ->
    {canEdit} = @context

    return unless canEdit
    @setState edit: true

  stopEdit: ->
    {object} = @props

    @setState edit: false

  restrictEnter: (event) ->
    return unless event.key == 'Enter'
    event.preventDefault()

  changeTitle: (event) ->
    {object, actions} = @props

    @app[actions].change object.id, title: event.target.value
    @queueUpdate @updateTitle

  updateTitle: ->
    {object, actions} = @props

    @app[actions].update object.id, title: object.title

  titleView: ->
    {object, placeholder} = @props
    {edit} = @state
    {block} = @context

    return if edit

    <h1 className={@classes("#{block}_title")} onClick={@startEdit}>
      {object.title || placeholder}
    </h1>

  titleEdit: ->
    {object, placeholder} = @props
    {edit} = @state
    {block} = @context

    return unless edit

    withIndexKeys [
      <Textarea autoFocus maxLength="90" className={@classes("#{block}_title", 'm-edit')} placeholder={placeholder} value={object.title} onChange={@changeTitle} onKeyDown={@restrictEnter} onBlur={@stopEdit}/>
    ]

  render: ->
    {block} = @context

    <div className="#{block}_title-wrapper">
      {@titleView()}
      {@titleEdit()}
    </div>

module.exports = ObjectTitle
