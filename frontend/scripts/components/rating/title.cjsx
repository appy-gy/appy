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
    edit: PropTypes.bool.isRequired
    placeholder: PropTypes.string.isRequired
    minFontSize: PropTypes.number.isRequired
    maxFontSize: PropTypes.number.isRequired
    maxHeight: PropTypes.number.isRequired
    onFontSizeChange: PropTypes.func

  contextTypes:
    block: PropTypes.string.isRequired
    onFontSizeChange: ->

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
    {object, edit, placeholder} = @props
    {block} = @context

    if edit
      <textarea ref="titleEdit" maxLength="90" className={@classes("#{block}_title", 'm-edit')} placeholder={placeholder} value={object.title} onChange={@changeTitle} onKeyDown={@restrictEnter}/>
    else
      <h1 ref="titleView" className={@classes("#{block}_title")}>
        {object.title}
      </h1>

  render: ->
    {object, minFontSize, maxFontSize, maxHeight, onFontSizeChange} = @props
    {block} = @context

    <div className="#{block}_title-wrapper">
      <Textfill minFontSize={minFontSize} maxFontSize={maxFontSize} maxHeight={maxHeight} onFontSizeChange={onFontSizeChange} content={object.title}>
        {@title()}
      </Textfill>
    </div>

module.exports = ObjectTitle
