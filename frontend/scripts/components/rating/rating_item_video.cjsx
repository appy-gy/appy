_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingItemActions = require '../../actions/rating_items'
http = require '../../helpers/http'
RatingUpdater = require '../mixins/rating_updater'

{PropTypes} = React
{connect} = ReactRedux
{changeRatingItem, updateRatingItem} = ratingItemActions

RatingItemVideo = React.createClass
  displayName: RatingItemVideo

  mixins: [RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    ratingItem: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  getInitialState: ->
    {ratingItem} = @context

    showInput: not _.isEmpty(ratingItem.video)

  showInput: ->
    @setState showInput: true
    setImmediate =>
      @refs.input.focus()

  hideInput: ->
    @setState showInput: false

  getVideoInfo: (url) ->
    http.get 'rating_items/video_info', params: { url }

  updateVideo: (event) ->
    {dispatch} = @props
    {ratingItem} = @context
    {value: url} = event.target

    return if _.isEmpty url

    @getVideoInfo(url).then ({data}) =>
      return if _.isEmpty data
      dispatch changeRatingItem(ratingItem.id, video: data)
      @queueUpdate ->
        dispatch updateRatingItem(ratingItem.id, videoUrl: url)

  removeVideo: ->
    {dispatch} = @props
    {ratingItem} = @context

    @hideInput()
    dispatch changeRatingItem(ratingItem.id, video: {})
    @queueUpdate ->
      dispatch updateRatingItem(ratingItem.id, videoUrl: '')

  player: ->
    {ratingItem} = @context

    return if _.isEmpty ratingItem.video

    <iframe className="rating-item_video" src={ratingItem.video.embed} allowFullScreen frameBorder="0"></iframe>

  input: ->
    {showInput} = @state
    {canEdit} = @context

    return unless canEdit and showInput

    <input ref="input" type="text" className="rating-item_video-input" placeholder="Вставьте ссылка на видео на youtube или vimeo" onBlur={@updateVideo}/>

  addVideoButton: ->
    {canEdit} = @context

    return unless canEdit

    <div className="rating-item_add-video" onClick={@showInput}></div>

  removeVideoButton: ->
    {ratingItem, canEdit} = @context

    return if not canEdit or _.isEmpty(ratingItem.video)

    <div className="rating-item_remove-video" title="Удалить видео" onClick={@removeVideo}>
      Удалить видео
    </div>

  render: ->
    {ratingItem} = @context

    classes = classNames 'rating-item_attachment-video', 'm-chosen': not _.isEmpty ratingItem.video

    <div className={classes}>
      {@addVideoButton()}
      {@removeVideoButton()}
      {@input()}
      {@player()}
    </div>

module.exports = connect()(RatingItemVideo)
