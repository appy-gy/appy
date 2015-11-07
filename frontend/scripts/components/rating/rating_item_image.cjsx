React = require 'react'
ReactDOM = require 'react-dom'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingItemActions = require '../../actions/rating_items'
WithFileInput = require '../mixins/with_file_input'
RatingUpdater = require '../mixins/rating_updater'
FileInput = require '../shared/inputs/file'
withIndexKeys = require '../../helpers/react/with_index_keys'
imageUrl = require '../../helpers/image_url'
isClient = require '../../helpers/is_client'

{PropTypes} = React
{connect} = ReactRedux
{changeRatingItem, updateRatingItem} = ratingItemActions

RatingItemImage = React.createClass
  displayName: 'RatingItemImage'

  mixins: [PureRendexMixin, WithFileInput, RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired
    ratingItem: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  buttonTypes: ['updateImage', 'removeImage']

  getInitialState: ->
    width: null

  componentDidMount: ->
    return unless isClient()
    width = ReactDOM.findDOMNode(@).offsetWidth
    @setState { width }

  buttons: ->
    {canEdit} = @props

    return [] unless canEdit

    @buttonTypes.map (type) => @["#{type}Button"]()

  imageUrlFor: ({props}) ->
    imageUrl props.ratingItem.image, 'normal'

  updateImage: (files) ->
    {dispatch, ratingItem} = @props

    image = files[0]
    return unless image?

    dispatch changeRatingItem(ratingItem.id, image: image.preview)
    @queueUpdate ->
      dispatch updateRatingItem(ratingItem.id, { image })

  removeImage: ->
    {dispatch, ratingItem} = @props

    dispatch changeRatingItem(ratingItem.id, image: null)
    @queueUpdate ->
      dispatch updateRatingItem(ratingItem.id, removeImage: true)

  image: ->
    {ratingItem, canEdit} = @props
    {width} = @state

    styles = if not canEdit and width?
      height: Math.round ratingItem.imageHeight * width / ratingItem.imageWidth

    image = <img className="rating-item_image" src={@imageUrl()} style={styles}/>
    unless canEdit
      image = <a target="_blank" href={imageUrl ratingItem.image}>{image}</a>
    image

  updateImageButton: ->
    <div className="rating-item_add-image" title="Выберите изображение" onClick={@openSelect}>
    </div>

  removeImageButton: ->
    {ratingItem} = @props

    return unless ratingItem.image?

    <div className="rating-item_remove-image" title="Удалить изображение" onClick={@removeImage}>
    </div>

  children: ->
    {ratingItem} = @props

    withIndexKeys [
      @buttons()...
      @image()
    ]

  render: ->
    {ratingItem, canEdit} = @props

    classes = classNames 'rating-item_attachment-image', 'm-chosen': ratingItem.image?

    return <div className={classes}>{@children()}</div> unless canEdit

    <FileInput className={classes} onSelect={@updateImage} {...@fileInputProps()}>
      {@children()}
    </FileInput>

module.exports = connect()(RatingItemImage)
