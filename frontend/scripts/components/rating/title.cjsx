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

  getInitialState: ->
    edit: false

  startEdit: ->
    @setState edit: true

  rollbackTitle: ->
    @setState edit: false

  updateTitle: (event) ->
    @props.onChange event.target.value

  titleCommon: ->
    {title} = @props
    {edit} = @state

    return if edit

    <h1 className="rating_title" onClick={@startEdit}>
      {title}
    </h1>

  titleEditable: ->
    {title} = @props
    {edit} = @state

    return unless edit

    <div>
      <textarea maxLength="50" className="rating_title edit" value={title} onChange={@updateTitle} ></textarea>
      <button onClick={@updateTitle}>сохранить</button><button onClick={@rollbackTitle}>отменить</button>
    </div>

  render: ->
    <div>
      {@titleCommon()}
      {@titleEditable()}
    </div>

module.exports = RatingTitle
