React = require 'react/addons'
RatingsStore = require '../../stores/ratings'
RatingsApi = require '../../state_sources/ratings'
RatingsActionCreator = require '../../action_creators/ratings'

{PropTypes} = React
{PureRenderMixin} = React.addons

RatingTitle = React.createClass
  displayName: 'Title'

  # mixins: [PureRenderMixin]

  # propTypes:
  #   rating: PropTypes.object.isRequired

  contextTypes:
    rating: PropTypes.object.isRequired

  getInitialState: ->
    edit: false

  startEdit: ->
    @setState edit: true

  rollbackTitle: ->
    @setState edit: false

  updateTitle: (event) ->
    {rating} = @context
    RatingsActionCreator.change rating.id, { title: event.target.value }

  titleCommon: ->
    {title} = @context.rating
    {edit} = @state

    return if edit

    <h1 className="rating_title" onClick={@startEdit}>
      {title}
    </h1>

  titleEditable: ->
    {title} = @context.rating
    {edit} = @state

    return unless edit

    <div>
      <textarea maxLength="50" className="rating_title edit" value={title} onChange={@updateTitle}></textarea>
      <button onClick={@updateTitle}>
        сохранить
      </button>
      <button onClick={@rollbackTitle}>
        отменить
      </button>
    </div>

  render: ->
    <div>
      {@titleCommon()}
      {@titleEditable()}
    </div>

module.exports = RatingTitle
