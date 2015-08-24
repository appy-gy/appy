_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
AutolinkText = require 'react-autolink-text'
RatingUpdater = require '../mixins/rating_updater'
Textarea = require '../shared/inputs/text'
removeExtraSpaces = require '../../helpers/remove_extra_spaces'

{PropTypes} = React

Source = React.createClass
  displayName: 'Source'

  mixins: [Marty.createAppMixin(), RatingUpdater]

  contextTypes:
    rating: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  placeholder: 'Источник'

  getInitialState: ->
    edit: false

  startEdit: ->
    {canEdit} = @context

    return unless canEdit
    @setState edit: true

  stopEdit: ->
    @setState edit: false

  changeSource: (event) ->
    {rating} = @context

    source = event.target.value

    @app.ratingsActions.change rating.id, { source }
    @queueUpdate =>
      @app.ratingsActions.update rating.id, source: removeExtraSpaces(source)

  sourceView: ->
    {edit} = @state
    {rating} = @context

    return if edit

    <div className="rating_source" onClick={@startEdit}>
      <AutolinkText text={rating.source || @placeholder}></AutolinkText>
    </div>

  sourceEdit: ->
    {edit} = @state
    {rating} = @context

    return unless edit

    <Textarea autoFocus className="rating_source m-edit" placeholder={@placeholder} value={rating.source} onChange={@changeSource} onBlur={@stopEdit}/>

  render: ->
    <div className="rating_source-wrapper">
      {@sourceView()}
      {@sourceEdit()}
    </div>

module.exports = Source
