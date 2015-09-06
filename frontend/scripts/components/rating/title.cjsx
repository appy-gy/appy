_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
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
    edit: PropTypes.bool.isRequired
    placeholder: PropTypes.string.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  restrictEnter: (event) ->
    return unless event.key == 'Enter'
    event.preventDefault()

  changeTitle: (event) ->
    {object, actions} = @props

    title = event.target.value

    @app[actions].change object.id, { title }
    @queueUpdate =>
      @app[actions].update object.id, { title }, true

  title: ->
    {object, edit, placeholder} = @props
    {block} = @context

    if edit
      <Textarea maxLength="90" className={@classes("#{block}_title", 'm-edit')} placeholder={placeholder} value={object.title} onChange={@changeTitle} onKeyDown={@restrictEnter}/>
    else
      <h1 className={@classes("#{block}_title")}>
        {object.title}
      </h1>

  render: ->
    {object} = @props
    {block} = @context

    <div className="#{block}_title-wrapper">
      {@title()}
    </div>

module.exports = ObjectTitle
