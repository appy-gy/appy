_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/rating'
RatingUpdater = require '../mixins/rating_updater'
Editor = require '../shared/inputs/editor'

{PropTypes} = React
{connect} = ReactRedux
{changeRating, updateRating} = ratingActions

Source = React.createClass
  displayName: 'Source'

  mixins: [PureRendexMixin, RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired
    edit: PropTypes.bool.isRequired

  editorOptions:
    placeholder:
      text: 'Введите источник (оставьте поле пустым, если материал является авторским)'

  changeSource: (source) ->
    {dispatch, rating} = @props

    dispatch changeRating({ source })
    @queueUpdate ->
      dispatch updateRating({ source })

  sourceView: ->
    {rating} = @props

    <div className="rating_description" dangerouslySetInnerHTML={__html: rating.source}></div>

  sourceEdit: ->
    {rating} = @props

    <Editor className="rating_description m-edit" value={rating.source} onChange={@changeSource} options={@editorOptions}/>

  source: ->
    {edit} = @props

    component = if edit then @sourceEdit() else @sourceView()
    component

  render: ->
    <div className="rating_description-wrapper m-bottom">
      {@source()}
    </div>

module.exports = connect()(Source)
