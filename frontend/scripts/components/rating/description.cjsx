React = require 'react/addons'
RatingsStore = require '../../stores/ratings'
RatingsApi = require '../../state_sources/ratings'
RatingsActionCreator = require '../../action_creators/ratings'

{PropTypes} = React
{PureRenderMixin} = React.addons

RatingDescription = React.createClass
  displayName: 'Description'

  contextTypes:
    rating: PropTypes.object.isRequired

  getInitialState: ->
    edit: false

  startEdit: ->
    @setState edit: true

  stopEdit: ->
    @setState edit: false

  updateDescription: (event) ->
    {rating} = @context
    RatingsActionCreator.change rating.id, { description: event.target.value }

  saveDescription: ->
    {rating} = @context
    RatingsActionCreator.update rating.id, { description: rating.description }
    @stopEdit()

  descriptionCommon: ->
    {description} = @context.rating
    {edit} = @state

    return if edit

    <h1 className="rating_description" onClick={@startEdit}>
      {description}
    </h1>

  descriptionEditable: ->
    {description} = @context.rating
    {edit} = @state

    return unless edit

    <div>
      <textarea className="rating_description edit" value={description} onChange={@updateDescription}></textarea>
      <button onClick={@saveDescription}>
        сохранить
      </button>
      <button onClick={@stopEdit}>
        отменить
      </button>
    </div>

  render: ->
    <div>
      {@descriptionCommon()}
      {@descriptionEditable()}
    </div>

module.exports = RatingDescription