React = require 'react'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingItemActions = require '../../actions/rating_items'
WithFileInput = require '../mixins/with_file_input'
RatingUpdater = require '../mixins/rating_updater'
FileInput = require '../shared/inputs/file'
withIndexKeys = require '../../helpers/react/with_index_keys'
imageUrl = require '../../helpers/image_url'

{PropTypes} = React
{connect} = ReactRedux
{changeRatingItem, updateRatingItem} = ratingItemActions

RatingItemImage = React.createClass
  displayName: 'RatingItemImage'

  mixins: [WithFileInput, RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    ratingItem: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  buttonTypes: ['updateImage', 'removeImage']

  buttons: ->
    {canEdit} = @context

    return [] unless canEdit

    @buttonTypes.map (type) => @["#{type}Button"]()

  imageUrlFor: ({context}) ->
    imageUrl context.ratingItem.image, 'normal'

  updateImage: (files) ->
    {dispatch} = @props
    {ratingItem} = @context

    image = files[0]
    return unless image?

    dispatch changeRatingItem(ratingItem.id, image: image.preview)
    @queueUpdate ->
      dispatch updateRatingItem(ratingItem.id, { image })

  removeImage: ->
    {dispatch} = @props
    {ratingItem} = @context

    dispatch changeRatingItem(ratingItem.id, image: null)
    @queueUpdate ->
      dispatch updateRatingItem(ratingItem.id, removeImage: true)

  image: ->
    {canEdit} = @context

    image = <img className="rating-item_cover-image" src={@imageUrl()} width=800 height=600 />
    unless canEdit
      image = <a target="_blank" href={@imageUrl()}>{image}</a>
    image

  updateImageButton: ->
    <div className="rating-item_add-image" title="Выберите изображение" onClick={@openSelect}>

    </div>

  removeImageButton: ->
    {ratingItem} = @context

    return unless ratingItem.image?

    <div className="rating-item_remove-image" title="Удалить изображение" onClick={@removeImage}>
    </div>

  children: ->
    {ratingItem} = @context

    withIndexKeys [
      @buttons()...
      @image()
    ]

  render: ->
    {ratingItem, canEdit} = @context

    classes = classNames 'rating-item_cover', 'm-with-image': ratingItem.image?

    return <div className={classes}>{@children()}</div> unless canEdit

    <FileInput className={classes} onSelect={@updateImage} {...@fileInputProps()}>
      {@children()}
    </FileInput>

module.exports = connect()(RatingItemImage)
