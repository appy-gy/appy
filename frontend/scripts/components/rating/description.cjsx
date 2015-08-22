_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
isBlank = require '../../helpers/is_blank'
withIndexKeys = require '../../helpers/react/with_index_keys'
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
    {object} = @props

    edit: false

  startEdit: ->
    {object} = @props
    {canEdit} = @context

    return unless canEdit
    @setState edit: true

  stopEdit: ->
    {object} = @props

    @setState edit: false

  changeDescription: (event) ->
    {object, actions} = @props

    description = event.target.value

    @app[actions].change object.id, { description }
    @queueUpdate =>
      @app[actions].update object.id, description: removeExtraSpaces(description)

  descriptionView: ->
    {object, placeholder} = @props
    {edit} = @state
    {block} = @context
    {description} = object

    return if edit

    <div className={@classes("#{block}_description")} onClick={@startEdit}>
      {description || placeholder}
    </div>

  descriptionEdit: ->
    {object, placeholder} = @props
    {edit} = @state
    {block} = @context

    return unless edit

    withIndexKeys [
      <Textarea className={@classes("#{block}_description", 'm-edit')} placeholder={placeholder} value={object.description} onChange={@changeDescription} onBlur={@stopEdit}/>
    ]

  render: ->
    {block} = @context

    <div className="#{block}_description-wrapper">
      {@descriptionView()}
      {@descriptionEdit()}
    </div>

module.exports = ObjectDescription
