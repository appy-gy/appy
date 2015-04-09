React = require 'react/addons'
RatingsStore = require '../../stores/ratings'
RatingsApi = require '../../state_sources/ratings'
RatingsActionCreator = require '../../action_creators/ratings'
isBlank = require '../../helpers/is_blank'

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
    {rating} = @context
    edit: isBlank(rating.title)

  startEdit: ->
    @setState edit: true

  stopEdit: ->
    {rating} = @context
    @setState edit: false unless isBlank(rating.title)

  updateTitle: (event) ->
    {rating} = @context
    RatingsActionCreator.change rating.id, { title: event.target.value }

  saveTitle: ->
    {rating} = @context
    RatingsActionCreator.update rating.id, { title: rating.title }
    @stopEdit()

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
      <textarea autoFocus={true} maxLength="50" className="rating_title edit" value={title} onChange={@updateTitle} placeholder="Введи заголовок рейтинга"></textarea>
      <div className="rating_title-buttons">
        <button className="rating_title-button accept" onClick={@saveTitle}>
          сохранить
        </button>
        <button className="rating_title-button cancel" onClick={@stopEdit}>
          отменить
        </button>
      </div>
    </div>

  render: ->
    <div className="rating_title-wrapper">
      {@titleCommon()}
      {@titleEditable()}
    </div>

module.exports = RatingTitle
