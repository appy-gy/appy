React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
Title = require './title'
SectionsSelect = require './sections_select'
Tags = require '../shared/ratings/tags'
TagsSelect = require './tags_select'
Meta = require '../shared/ratings/meta'
FileInput = require '../shared/file_input'

{PropTypes} = React

Header = React.createClass
  displayName: 'Header'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    rating: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  ratingImageButton: ->
    {rating, canEdit} = @context

    return unless canEdit

    <FileInput className="rating_add-image" onChange={@updateImage}>
    </FileInput>

  updateImage: (files) ->
    {rating} = @context

    image = files[0]
    return unless image?

    url = URL.createObjectURL image

    @app.ratingsActions.change rating.id, image: url
    @app.ratingsActions.update rating.id, { image }

  render: ->
    {rating} = @context

    classes = classNames 'rating_header', 'm-with-image': rating.image?

    <header className={classes}>
      <div className="rating_cover" style={backgroundImage: "url(#{rating.imageUrl('normal')})"}>
      </div>
      <Meta/>
      {@ratingImageButton()}
      <div className="rating_section-name-wrapper">
        <SectionsSelect object={rating} actions="ratingsActions"/>
      </div>
      <div className="rating_tags-select">
        <TagsSelect/>
      </div>
      <Title object={rating} actions="ratingsActions" maxRows={3}/>
      <Tags/>
    </header>

module.exports = Header
