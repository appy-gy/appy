React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
WithFileInput = require '../mixins/with_file_input'
Title = require './title'
SectionsSelect = require './sections_select'
Tags = require '../shared/ratings/tags'
TagsSelect = require './tags_select'
Meta = require '../shared/ratings/meta'
FileInput = require '../shared/file_input'
withIndexKeys = require '../../helpers/react/with_index_keys'

{PropTypes} = React

Header = React.createClass
  displayName: 'Header'

  mixins: [Marty.createAppMixin(), WithFileInput]

  contextTypes:
    rating: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  updateImage: (files) ->
    {rating} = @context

    image = files[0]
    return unless image?

    @app.ratingsActions.change rating.id, image: image.preview
    @app.ratingsActions.update rating.id, { image }

  ratingImageButton: ->
    {rating, canEdit} = @context

    return unless canEdit

    <div className="rating_add-image" onClick={@openSelect}></div>

  tags: ->
    {rating} = @context

    return unless rating.status == 'published'

    <Tags/>

  children: ->
    {rating} = @context

    withIndexKeys [
      <div className="rating_cover" style={backgroundImage: "url(#{rating.imageUrl('normal')})"}></div>
      <Meta/>
      @ratingImageButton()
      <div className="rating_section-name-wrapper">
        <SectionsSelect object={rating} actions="ratingsActions"/>
      </div>
      <div className="rating_tags-select">
        <TagsSelect/>
      </div>
      <Title object={rating} actions="ratingsActions"/>
      @tags()
    ]

  render: ->
    {rating, canEdit} = @context

    classes = classNames 'rating_header', 'm-with-image': rating.image?

    return <div className={classes}>{@children()}</div> unless canEdit

    <FileInput className={classes} onSelect={@updateImage} {...@fileInputProps()}>
      {@children()}
    </FileInput>

module.exports = Header
