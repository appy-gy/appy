_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/rating'
classNames = require 'classnames'
WithFileInput = require '../mixins/with_file_input'
RatingUpdater = require '../mixins/rating_updater'
Title = require './title'
Close = require './close'
SectionSelect = require './section_select'
SortSwitch = require './sort_switch'
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

  mixins: [PureRendexMixin, WithFileInput, RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired

  imageUrlFor: ({props}) ->
    imageUrl props.rating.image, 'normal'

  updateImage: (files) ->
    {dispatch, rating} = @props

    image = files[0]
    return unless image?

    dispatch changeRating(image: image.preview)
    @queueUpdate ->
      dispatch updateRating({ image })

  meta: ->
    {rating} = @props

    return unless rating.status == 'published'

    <Meta rating={rating} commentsAnchor="comments"/>

  ratingImageButton: ->
    {rating} = @props

    return if rating.status == 'published'

    <div className="rating_add-image-wrap">
      <div className="rating_add-image" title="Выберите фото обложки" onClick={@openSelect}></div>
      <div className="rating_drop-area">
        <div className="rating_drop-area-icon"></div>
        <div className="rating_drop-area-text">
          Можете просто перетянуть изображение в эту зону для загрузки
        </div>
      </div>
    </div>

  sectionLink: ->
    {rating} = @props

    return unless rating.status == 'published'

    sectionNameStyles = _.pick rating.section, 'color'
    <SectionLink className="rating_section-name" section={rating.section} style={sectionNameStyles}>
      {rating.section?.name}
    </SectionLink>

  sectionSelect: ->
    {rating} = @props

    <SectionSelect rating={rating}/> unless rating.status == 'published'

  sortSwitch: ->
    <SortSwitch/> if @props.rating.status == 'published'

  tagsSelect: ->
    {rating} = @props

    <TagsSelect rating={rating}/> unless rating.status == 'published'

  tags: ->
    {rating} = @props

    <Tags rating={rating}/> if rating.status == 'published'

  children: ->
    {rating} = @props

    edit = rating.status != 'published'

    withIndexKeys [
      <div className="rating_cover" style={backgroundImage: "url(#{@imageUrl()})"}></div>
      <Close/>
      @meta()
      @ratingImageButton()
      <div className="rating_header-center">
        <div className="rating_section-name-wrapper">
          {@sectionLink()}
          {@sectionSelect()}
        </div>
        <Title object={rating} objectType="rating" passObjectId={false} edit={edit} placeholder="Введите заголовок рейтинга"/>
        {@sortSwitch()}
      </div>
      @tagsSelect()
      @tags()
    ]

  render: ->
    {rating} = @props

    classes = classNames 'rating_header', 'm-with-image': rating.image?

    return <div className={classes}>{@children()}</div> if rating.status == 'published'

    <FileInput className={classes} onSelect={@updateImage} {...@fileInputProps()}>
      {@children()}
    </FileInput>

module.exports = connect()(Header)
