React = require 'react/addons'
Title = require './title'
SectionsSelect = require './sections_select'
TagsSelect = require './tags_select'
Meta = require '../shared/ratings/meta'
RatingActionCreators = require '../../action_creators/ratings'
FileInput = require '../shared/file_input'

{PropTypes} = React

Header = React.createClass
  displayName: 'Header'

  contextTypes:
    rating: PropTypes.object.isRequired

  ratingImageButton: ->
    {rating} = @context

    return unless rating.canEdit

    <FileInput style={position: 'relative'} onChange={@updateImage}>
      Загрузить изображение
    </FileInput>

  updateImage: (files) ->
    {rating} = @context

    image = files[0]
    return unless image?

    url = URL.createObjectURL image

    RatingActionCreators.change rating.id, image: url
    RatingActionCreators.update rating.id, { image }

  render: ->
    {rating} = @context

    <header className="rating_header" style={backgroundImage: "url(#{rating.imageUrl('normal')})"}>
      <Meta/>
      {@ratingImageButton()}
      <SectionsSelect object={rating} actionCreator={RatingActionCreators}/>
      <TagsSelect/>
      <Title object={rating} actionCreator={RatingActionCreators}/>
    </header>

module.exports = Header
