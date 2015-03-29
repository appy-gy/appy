React = require 'react/addons'
RatingActionCreators = require '../../action_creators/ratings'

{PropTypes} = React
{PureRenderMixin} = React.addons

RatingTitle = React.createClass
  displayName: 'Title'

  mixins: [PureRenderMixin]

  propTypes:
    rating: PropTypes.object.isRequired

  getInitialState: ->
    edit: false

  startEdit: ->
    @setState edit: true

  rollbackTitle: ->
    @setState edit: false

  updateTitle: (event) ->
    {rating} = @props

    RatingActionCreators.change rating.id, title: event.target.value

  titleCommon: ->
    {rating} = @props
    {edit} = @state

    return if edit

    <h1 className="rating_title" onClick={@startEdit}>
      {rating.title}
    </h1>

  titleEditable: ->
    {rating} = @props
    {edit} = @state

    return unless edit

    <div>
      <textarea maxLength="50" className="rating_title edit" value={rating.title} onChange={@updateTitle}></textarea>
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
