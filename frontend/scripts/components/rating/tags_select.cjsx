_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
Select = require 'react-select'
http = require '../../helpers/http'
ratingActions = require '../../actions/rating'

{PropTypes} = React
{connect} = ReactRedux
{addTagToRating, removeTagFromRating} = ratingActions

TagsSelect = React.createClass
  displayName: 'TagsSelect'

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired

  popularOptionsCallbacks: []

  toOptions: (tags) ->
    tags.map (tag) ->
      value: tag.name, label: tag.name, ratingsCount: tag.ratingsCount

  getPopularOptions: (callback) ->
    return callback null, options: @popularOptions if @popularOptions?

    @popularOptionsCallbacks.push callback
    return if @requestedPopularOptions
    @requestedPopularOptions = true

    http.get('tags/popular').then ({data}) =>
      @popularOptions = @toOptions data.tags
      @popularOptionsCallbacks.each (callback) =>
        callback null, options: @popularOptions

    true

  loadOptions: (query, callback) ->
    # React-select passes current values instead of an empty string when
    # initialized or after adding/removing a value from the values list
    return @getPopularOptions callback if _.isArray query

    http.get('tags', params: { query }).then ({data}) =>
      callback null, options: @toOptions(data.tags)

    true

  value: ->
    _.map @props.rating.tags, 'name'

  updateTags: (newValue, options) ->
    {dispatch, rating} = @props

    names = _.xor _.map(rating.tags, 'name'), _.map(options, 'value')
    action = if options.length > rating.tags.length then addTagToRating else removeTagFromRating
    names.each (name) -> dispatch action(name)

  createNewOption: (query) ->
    label: query, value: query, ratingsCount: 0

  renderOption: ({label, ratingsCount}) ->
    numberOfUses = if ratingsCount == 0 then 'новый' else ratingsCount

    <div className="tag-option">
      <div className="tag-option_label">
        {label}
      </div>
      <div className="tag-option_number-of-uses">
        ({numberOfUses})
      </div>
    </div>

  render: ->
    <div className="rating_tags-select">
      <Select placeholder="Укажите теги" noResultsText="Ничего такого нет" searchPromptText="Начните вводить" clearValueText="Удалить тег" clearAllText="Удалить все теги" clearable={false} autoload={false} multi={true} allowCreate={true} matchProp="label" asyncOptions={@loadOptions} value={@value()} newOptionCreator={@createNewOption} optionRenderer={@renderOption} onChange={@updateTags}/>
    </div>

module.exports = connect()(TagsSelect)
