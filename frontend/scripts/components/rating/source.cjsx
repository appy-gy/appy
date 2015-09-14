_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/rating'
AutolinkText = require 'react-autolink-text'
RatingUpdater = require '../mixins/rating_updater'
Textarea = require '../shared/inputs/text'
removeExtraSpaces = require '../../helpers/remove_extra_spaces'

{PropTypes} = React
{connect} = ReactRedux
{changeRating, updateRating} = ratingActions

Source = React.createClass
  displayName: 'Source'

  mixins: [RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    rating: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  placeholder: 'Источник'

  getInitialState: ->
    edit: false

  startEdit: ->
    @setState edit: true if @context.canEdit

  stopEdit: ->
    @setState edit: false

  changeSource: (event) ->
    {dispatch} = @props
    {rating} = @context

    source = event.target.value

    dispatch changeRating({ source })
    @queueUpdate ->
      dispatch updateRating({ source })

  sourceView: ->
    {edit} = @state
    {rating} = @context

    return if edit

    <div className="rating_description" onClick={@startEdit}>
      <AutolinkText text={removeExtraSpaces(rating.source) || @placeholder}></AutolinkText>
    </div>

  sourceEdit: ->
    {edit} = @state
    {rating} = @context

    return unless edit

    <Textarea autoFocus className="rating_description m-edit" placeholder={@placeholder} value={rating.source} onChange={@changeSource} onBlur={@stopEdit}/>

  render: ->
    <div className="rating_description-wrapper m-bottom">
      {@sourceView()}
      {@sourceEdit()}
    </div>

module.exports = connect()(Source)
