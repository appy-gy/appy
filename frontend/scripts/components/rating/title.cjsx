React = require 'react/addons'
RatingsStore = require '../../stores/ratings'

{PropTypes} = React
{PureRenderMixin} = React.addons

RatingTitle = React.createClass
  displayName: 'Title'

  mixins: [PureRenderMixin]

  propTypes:
    text: PropTypes.string.isRequired

  getInitialState: ->
    edit: false

  startEdit: ->
    @setState edit: true

  rollbackTitle: ->
    @setState edit: false

  updateTitle: (event) ->
    @props.onChange event.target.value

  titleCommon: ->
    {text} = @props
    {edit} = @state

    return if edit

    <h1 className="rating_title" onClick={@startEdit}>
      {text}
    </h1>

  titleEditable: ->
    {text} = @props
    {edit} = @state

    return unless edit

    <div>
      <textarea maxLength="50" className="rating_title edit" value={text} onChange={@updateTitle}></textarea>
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
