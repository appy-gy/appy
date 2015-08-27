_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
textfill = require 'textfill'
isClient = require '../../helpers/is_client'
Classes = require '../mixins/classes'
RatingUpdater = require '../mixins/rating_updater'

{PropTypes} = React

ObjectTitle = React.createClass
  displayName: 'Title'

  mixins: [Marty.createAppMixin(), Classes, RatingUpdater]

  propTypes:
    object: PropTypes.object.isRequired
    actions: PropTypes.string.isRequired
    placeholder: PropTypes.string.isRequired
    minFontSize: PropTypes.number.isRequired
    maxFontSize: PropTypes.number.isRequired

  contextTypes:
    block: PropTypes.string.isRequired
    canEdit: PropTypes.bool.isRequired

  getInitialState: ->
    edit: false

  componentDidMount: ->
    @updateFontSize()

  componentDidUpdate: ->
    @updateFontSize()

  updateFontSize: ->
    {minFontSize, maxFontSize} = @props
    {edit} = @state
    {titleView, titleEdit} = @refs

    return unless isClient()

    textfill titleView.getDOMNode(), minFontPixels: minFontSize, maxFontPixels: maxFontSize, explicitHeight: 200
    return unless edit
    titleEdit.getDOMNode().style.fontSize = titleView.getDOMNode().children[0].style.fontSize

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

    title = event.target.value

    @app[actions].change object.id, { title }
    @queueUpdate =>
      @app[actions].update object.id, { title }

  titleView: ->
    {object, placeholder} = @props
    {edit} = @state
    {block} = @context

    <h1 ref="titleView" className={@classes("#{block}_title", 'm-hidden': edit)} onClick={@startEdit}>
      <div>
        {object.title || placeholder}
      </div>
    </h1>

  titleEdit: ->
    {object, placeholder} = @props
    {edit} = @state
    {block} = @context

    return unless edit

    <textarea ref="titleEdit" autoFocus maxLength="90" rows="3" className={@classes("#{block}_title", 'm-edit')} placeholder={placeholder} value={object.title} onChange={@changeTitle} onKeyDown={@restrictEnter} onBlur={@stopEdit}/>

  render: ->
    {block} = @context

    <div className="#{block}_title-wrapper">
      {@titleView()}
      {@titleEdit()}
    </div>

module.exports = ObjectTitle
