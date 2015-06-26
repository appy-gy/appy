React = require 'react/addons'
Marty = require 'marty'
WithFileInput = require '../mixins/with_file_input'
FileInput = require '../shared/file_input'
withIndexKeys = require '../../helpers/react/with_index_keys'

{PropTypes} = React

RatingItemImage = React.createClass
  displayName: 'RatingItemImage'

  mixins: [Marty.createAppMixin(), WithFileInput]

  contextTypes:
    ratingItem: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  buttonTypes: ['updateImage', 'removeImage']

  buttons: ->
    {canEdit} = @context

    return unless canEdit

    @buttonTypes.map (type) => @["#{type}Button"]()

  updateImage: (files) ->
    {ratingItem} = @context

    image = files[0]
    return unless image?

    @app.ratingItemsActions.change ratingItem.id, image: image.preview
    @app.ratingItemsActions.update ratingItem.id, { image }

  removeImage: ->
    {ratingItem} = @context

    @app.ratingItemsActions.update ratingItem.id, removeImage: true

  updateImageButton: ->
    <div className="rating-item_add-image" onClick={@openSelect}></div>

  removeImageButton: ->
    {ratingItem} = @context

    return unless ratingItem.image?

    <div className="rating-item_remove-image" onClick={@removeImage}>
      Удалить изображение
    </div>

  children: ->
    {ratingItem} = @context

    withIndexKeys [
      @buttons()...
      <img className="rating-item_cover-image" src={ratingItem.imageUrl('normal')}/>
    ]

  render: ->
    {canEdit} = @context

    classes = 'rating-item_cover'

    return <div className={classes}>{@children()}</div> unless canEdit

    <FileInput className={classes} onSelect={@updateImage} {...@fileInputProps()}>
      {@children()}
    </FileInput>

module.exports = RatingItemImage
