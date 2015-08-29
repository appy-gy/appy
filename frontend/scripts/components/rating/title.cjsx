_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Classes = require '../mixins/classes'
RatingUpdater = require '../mixins/rating_updater'
Textfill = require '../shared/textfill/textfill'

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
    rating: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  getInitialState: ->
    {rating} = @context

    edit: rating.status != 'published'

  restrictEnter: (event) ->
    return unless event.key == 'Enter'
    event.preventDefault()

  changeTitle: (event) ->
    {object, actions} = @props

    title = event.target.value

    @app[actions].change object.id, { title }
    @queueUpdate =>
      @app[actions].update object.id, { title }

  title: ->
    {object, placeholder} = @props
    {edit} = @state
    {block} = @context

    if edit
      <textarea ref="titleEdit" maxLength="90" className={@classes("#{block}_title", 'm-edit')} placeholder={placeholder} value={object.title} onChange={@changeTitle} onKeyDown={@restrictEnter}/>
    else
      <h1 ref="titleView" className={@classes("#{block}_title", 'm-hidden': edit)}>
        {object.title || placeholder}
      </h1>

  render: ->
    {minFontSize, maxFontSize} = @props
    {block} = @context

    <div className="#{block}_title-wrapper" maxHeight={210}>
      <Textfill minFontSize={minFontSize} maxFontSize={maxFontSize}>
        {@title()}
      </Textfill>
    </div>

module.exports = ObjectTitle
