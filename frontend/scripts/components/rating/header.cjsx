React = require 'react/addons'
Title = require './title'
SectionsSelect = require './sections_select'
TagsSelect = require './tags_select'
Meta = require '../shared/ratings/meta'
RatingActionCreators = require '../../action_creators/ratings'

{PropTypes} = React

Header = React.createClass
  displayName: 'Header'

  contextTypes:
    rating: PropTypes.object.isRequired

  render: ->
    {rating} = @context

    <header className="rating_header">
      <Meta/>
      <div className="image-selector">
        <div className="image-selector_icon"></div>
        <div className="image-select_text">Загрузить изображение</div>
      </div>
      <SectionsSelect object={rating} actionCreator={RatingActionCreators}/>
      <TagsSelect/>
      <Title object={rating} actionCreator={RatingActionCreators}/>
    </header>

module.exports = Header
