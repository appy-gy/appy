_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
AutolinkText = require 'react-autolink-text'
Classes = require '../mixins/classes'
RatingUpdater = require '../mixins/rating_updater'
Textarea = require '../shared/inputs/text'
removeExtraSpaces = require '../../helpers/remove_extra_spaces'

{PropTypes} = React

ObjectDescription = React.createClass
  displayName: 'Description'

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
    @setState edit: false

  changeDescription: (event) ->
    {object, actions} = @props

    description = event.target.value

    @app[actions].change object.id, { description }
    @queueUpdate =>
      @app[actions].update object.id, { description }

  descriptionView: ->
    {object, placeholder} = @props
    {edit} = @state
    {block} = @context
    {description} = object

    return if edit

    <div className={@classes("#{block}_description")} onClick={@startEdit}>
      <AutolinkText text={removeExtraSpaces(description) || placeholder}></AutolinkText>
    </div>

  descriptionEdit: ->
    {object, placeholder} = @props
    {edit} = @state
    {block} = @context

    return unless edit

    <Textarea autoFocus className={@classes("#{block}_description", 'm-edit')} placeholder={placeholder} value={object.description} onChange={@changeDescription} onBlur={@stopEdit}/>

  render: ->
    {block} = @context

    <div className="#{block}_description-wrapper">
      {@descriptionView()}
      {@descriptionEdit()}
    </div>

module.exports = ObjectDescription
