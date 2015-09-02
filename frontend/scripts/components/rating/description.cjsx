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
    edit: PropTypes.bool.isRequired
    placeholder: PropTypes.string.isRequired

  contextTypes:
    rating: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  changeDescription: (event) ->
    {object, actions} = @props

    description = event.target.value

    @app[actions].change object.id, { description }
    @queueUpdate =>
      @app[actions].update object.id, { description }, true

  description: ->
    {object, edit, placeholder} = @props
    {block} = @context

    if edit
      <Textarea className={@classes("#{block}_description", 'm-edit')} placeholder={placeholder} value={object.description} onChange={@changeDescription}/>
    else
      <div className={@classes("#{block}_description")}>
        <AutolinkText text={removeExtraSpaces(object.description)}></AutolinkText>
      </div>

  render: ->
    {block} = @context

    <div className="#{block}_description-wrapper">
      {@description()}
    </div>

module.exports = ObjectDescription
