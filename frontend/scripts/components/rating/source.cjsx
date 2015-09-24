_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/rating'
RatingUpdater = require '../mixins/rating_updater'
Editor = require '../shared/inputs/editor'

{PropTypes} = React
{connect} = ReactRedux
{changeRating, updateRating} = ratingActions

Source = React.createClass
  displayName: 'Source'

  mixins: [RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired
    edit: PropTypes.bool.isRequired

  contextTypes:
    rating: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  editorOptions:
    placeholder:
      text: 'Введите источник (оставьте поле пустым, если материал является авторским)'

  changeSource: (source) ->
    {dispatch} = @props
    {rating} = @context

    dispatch changeRating({ source })
    @queueUpdate ->
      dispatch updateRating({ source })

  sourceView: ->
    {edit} = @props
    {rating} = @context

    return if edit

    <div className="rating_description" dangerouslySetInnerHTML={__html: rating.source}></div>

  sourceEdit: ->
    {edit} = @props
    {rating} = @context

    return unless edit

    <Editor className="rating_description m-edit" value={rating.source} onChange={@changeSource} options={@editorOptions}/>

  render: ->
    <div className="rating_description-wrapper m-bottom">
      {@sourceView()}
      {@sourceEdit()}
    </div>

module.exports = connect()(Source)
