React = require 'react/addons'
Title = require './title'
SectionsSelect = require './sections_select'
Tags = require '../shared/ratings/tags'
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

    <FileInput className="rating_add-image" onChange={@updateImage}>
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
      <div className="rating_section-name-wrapper">
        <SectionsSelect object={rating} actionCreator={RatingActionCreators}/>
      </div>
      <div className="rating_tags-select">
        <TagsSelect/>
      </div>
      <Title object={rating} actionCreator={RatingActionCreators}/>
      <Tags/>
    </header>

module.exports = Header
