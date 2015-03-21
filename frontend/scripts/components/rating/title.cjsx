React = require 'react/addons'
RatingsStore = require '../../stores/ratings'
RatingsApi = require '../../state_sources/ratings'

{PropTypes} = React
{PureRenderMixin, LinkedStateMixin} = React.addons

RatingTitle = React.createClass
  displayName: 'RatingTitle'

  mixins: [PureRenderMixin, LinkedStateMixin]

  propTypes:
    title: PropTypes.string.isRequired
    id: PropTypes.string.isRequired

  getInitialState: ->
    edit: false
    title: @props.title

  startEdit: ->
    @setState edit: true

  rollbackTitle: ->
    @setState edit: false

  updateTitle: ->
    {id} = @props
    {title} = @state
    RatingsApi.update { id, title }
    @setState edit: false

  titleCommon: ->
    {edit, title} = @state

    return if edit

    <h1 className="rating_title" onClick={@startEdit}>
      {title}
    </h1>

  titleEditable: ->
    {edit, title} = @state

    return unless edit

    <div>
      <textarea maxLength="50" className="rating_title edit" defaultValue={title} valueLink={@linkState('title')} ></textarea>
      <button onClick={@updateTitle}>сохранить</button><button onClick={@rollbackTitle}>отменить</button>
    </div>

  render: ->
    <div>
      {@titleCommon()}
      {@titleEditable()}
    </div>

module.exports = RatingTitle
