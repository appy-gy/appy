React = require 'react/addons'
Marty = require 'marty'
FileInput = require '../shared/file_input'

{PropTypes} = React

RatingItemImage = React.createClass
  displayName: 'RatingItemImage'

  mixins: [Marty.createAppMixin()]

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

    url = URL.createObjectURL image

    @app.ratingItemsActions.change ratingItem.id, image: url
    @app.ratingItemsActions.update ratingItem.id, { image }

  removeImage: ->
    {ratingItem} = @context

    @app.ratingItemsActions.update ratingItem.id, removeImage: true

  updateImageButton: ->
    <FileInput key="image" className="rating-item_add-image" onChange={@updateImage}>
    </FileInput>

  removeImageButton: ->
    {ratingItem} = @context

    return unless ratingItem.image?

    <div className="rating-item_remove-image" onClick={@removeImage}>
      Удалить изображение
    </div>

  render: ->
    {ratingItem} = @context

    <div className="rating-item_cover">
      {@buttons()}
      <img className="rating-item_cover-image" src={ratingItem.imageUrl('normal')}/>
    </div>

module.exports = RatingItemImage
