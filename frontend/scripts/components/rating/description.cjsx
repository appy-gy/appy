_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Textarea = require 'react-textarea-autosize'
Classes = require '../mixins/classes'
isBlank = require '../../helpers/is_blank'
withIndexKeys = require '../../helpers/react/with_index_keys'

{PropTypes} = React

ObjectDescription = React.createClass
  displayName: 'Description'

  mixins: [Marty.createAppMixin(), Classes]

  propTypes:
    object: PropTypes.object.isRequired
    actions: PropTypes.string.isRequired

  contextTypes:
    block: PropTypes.string.isRequired
    canEdit: PropTypes.bool.isRequired

  getInitialState: ->
    {object} = @props

    edit: isBlank object.description

  startEdit: ->
    {object} = @props
    {canEdit} = @context

    return unless canEdit
    @setState edit: true

  stopEdit: ->
    {object} = @props

    @setState edit: false unless isBlank(object.description)

  changeDescription: (event) ->
    {object, actions} = @props

    @app[actions].change object.id, description: event.target.value

  updateDescription: ->
    {object, actions} = @props

    @app[actions].update object.id, description: object.description
    @stopEdit()

  descriptionView: ->
    {object, className} = @props
    {edit} = @state
    {block} = @context
    {description} = object

    return if edit

    <div className={@classes("#{block}_description")} onClick={@startEdit}>
      {description}
    </div>

  descriptionEdit: ->
    {object, className} = @props
    {edit} = @state
    {block} = @context
    {description} = object

    return unless edit

    withIndexKeys [
      <Textarea className={@classes("#{block}_description", 'm-edit')} maxLength="90" value={description} onChange={@changeDescription} placeholder="Введи описание рейтинга"></Textarea>
      <div className="#{block}_description-buttons">
        <button className="#{block}_description-button m-accept" onClick={@updateDescription}>
          Cохранить
        </button>
        <button className="#{block}_description-button m-cancel" onClick={@stopEdit}>
        </button>
      </div>
    ]

  render: ->
    {block} = @context

    <div className="#{block}_description-wrapper">
      {@descriptionView()}
      {@descriptionEdit()}
    </div>

module.exports = ObjectDescription
