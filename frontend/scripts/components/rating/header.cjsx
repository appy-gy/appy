_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/rating'
classNames = require 'classnames'
WithFileInput = require '../mixins/with_file_input'
RatingUpdater = require '../mixins/rating_updater'
Title = require './title'
SectionSelect = require './section_select'
TagsSelect = require './tags_select'
Tags = require '../shared/ratings/tags'
Meta = require '../shared/ratings/meta'
FileInput = require '../shared/inputs/file'
SectionLink = require '../shared/links/section'
withIndexKeys = require '../../helpers/react/with_index_keys'
imageUrl = require '../../helpers/image_url'

{PropTypes} = React
{connect} = ReactRedux
{changeRating, updateRating} = ratingActions

Header = React.createClass
  displayName: 'Header'

  mixins: [WithFileInput, RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    rating: PropTypes.object.isRequired

  imageUrlFor: ({context}) ->
    {rating} = context

    imageUrl rating.image, 'normal'

  updateImage: (files) ->
    {dispatch} = @props
    {rating} = @context

    image = files[0]
    return unless image?

    dispatch changeRating(image: image.preview)
    @queueUpdate ->
      dispatch updateRating({ image })

  meta: ->
    {rating} = @context

    return unless rating.status == 'published'

    <Meta/>

  ratingImageButton: ->
    {rating} = @context

    return if rating.status == 'published'

    <div className="rating_add-image-wrap">
      <div className="rating_add-image" title="Выберите титульное изображение" onClick={@openSelect}></div>
    </div>

  sectionLink: ->
    {rating} = @context

    return unless rating.status == 'published'

    sectionNameStyles = _.pick rating.section, 'color'
    <SectionLink className="rating_section-name" section={rating.section} style={sectionNameStyles}>
      {rating.section?.name}
    </SectionLink>

  sectionSelect: ->
    {rating} = @context

    return if rating.status == 'published'

    <SectionSelect/>

  tags: ->
    {rating} = @context

    return unless rating.status == 'published'

    <Tags/>

  children: ->
    {rating} = @context

    edit = rating.status != 'published'

    withIndexKeys [
      <div className="rating_cover" style={backgroundImage: "url(#{@imageUrl()})"}></div>
      @meta()
      @ratingImageButton()
      <div className="rating_header-center">
        <div className="rating_section-name-wrapper">
          {@sectionLink()}
          {@sectionSelect()}
        </div>
        <Title object={rating} actions="ratingsActions" edit={edit} placeholder="Введите заголовок рейтинга"/>
      </div>
      <div className="rating_tags-select">
        <TagsSelect/>
      </div>
      @tags()
    ]

  render: ->
    {rating} = @context

    classes = classNames 'rating_header', 'm-with-image': rating.image?

    return <div className={classes}>{@children()}</div> if rating.status == 'published'

    <FileInput className={classes} onSelect={@updateImage} {...@fileInputProps()}>
      {@children()}
    </FileInput>

module.exports = connect()(Header)
