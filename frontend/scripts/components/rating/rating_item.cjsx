React = require 'react/addons'
Marty = require 'marty'
Title = require './title'
Description = require './description'
Votes = require './votes'
FileInput = require '../shared/file_input'

{PropTypes} = React

RatingItem = React.createClass
  displayName: 'RatingItem'

  mixins: [Marty.createAppMixin()]

  propTypes:
    ratingItem: PropTypes.object.isRequired
    index: PropTypes.number.isRequired

  childContextTypes:
    ratingItem: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {ratingItem} = @props

    { ratingItem, block: 'rating-item' }

  imageButton: ->
    {ratingItem} = @props

    return unless ratingItem.canEdit

    <FileInput className="rating-item_add-image" onChange={@updateImage}>
    </FileInput>

  updateImage: (files) ->
    {ratingItem} = @props

    image = files[0]
    return unless image?

    url = URL.createObjectURL image

    @app.ratingItemsActions.change ratingItem.id, image: url
    @app.ratingItemsActions.update ratingItem.id, { image }

  render: ->
    {ratingItem, index} = @props

    <section className="rating-item">
      <div className="rating-item_header">
        <span className="rating-item_number">{index}</span>
        <Title object={ratingItem} actions="ratingItemsActions"/>
      </div>
      <div className="rating-item_cover">
        {@imageButton()}
        <img className="rating-item_cover-image" src={ratingItem.imageUrl('normal')}/>
      </div>
      <div className="rating-item_description-wrapper">
        <Description object={ratingItem} actions="ratingItemsActions"/>
      </div>
      <Votes/>
    </section>

module.exports = RatingItem
