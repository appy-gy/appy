React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
WithFileInput = require '../mixins/with_file_input'
RatingUpdater = require '../mixins/rating_updater'
Title = require './title'
SectionsSelect = require './sections_select'
Tags = require '../shared/ratings/tags'
TagsSelect = require './tags_select'
Meta = require '../shared/ratings/meta'
FileInput = require '../shared/inputs/file'
withIndexKeys = require '../../helpers/react/with_index_keys'

{PropTypes} = React

Header = React.createClass
  displayName: 'Header'

  mixins: [Marty.createAppMixin(), WithFileInput, RatingUpdater]

  contextTypes:
    rating: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  imageUrlFor: ({context}) ->
    {rating} = context

    rating.imageUrl 'normal'

  updateImage: (files) ->
    {rating} = @context

    image = files[0]
    return unless image?

    @app.ratingsActions.change rating.id, image: image.preview
    @queueUpdate =>
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
      <div className="rating_cover" style={backgroundImage: "url(#{@imageUrl()})"}></div>
      <Meta/>
      @ratingImageButton()
      <div className="rating_section-name-wrapper">
        <SectionsSelect object={rating} actions="ratingsActions"/>
      </div>
      <div className="rating_tags-select">
        <TagsSelect/>
      </div>
      <Title object={rating} actions="ratingsActions" placeholder="Введите заголовок рейтинга"/>
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
