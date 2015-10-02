_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
Select = require 'react-select'
http = require '../../helpers/http'
ratingActions = require '../../actions/rating'
Nothing = require '../shared/nothing'

{PropTypes} = React
{connect} = ReactRedux
{addTagToRating, removeTagFromRating} = ratingActions

TagsSelect = React.createClass
  displayName: 'TagsSelect'

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    rating: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  toOptions: (tags) ->
    tags.map (tag) ->
      value: tag.name, label: tag.name, ratingsCount: tag.ratingsCount

  loadOptions: (query, callback) ->
    # React-select passes current values instead of an empty string when
    # initialized or after adding/removing a value from the values list
    query = '' if _.isArray query

    url = if _.isEmpty query then 'tags/popular' else 'tags'
    http.get(url, params: { query }).then ({data}) =>
      callback null, options: @toOptions(data.tags)

  value: ->
    _.map @context.rating.tags, 'name'

  updateTags: (newValue, options) ->
    {dispatch} = @props
    {rating} = @context

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
    {canEdit} = @context

    return <Nothing/> unless canEdit

    <Select placeholder="Укажите теги" noResultsText="Ничего такого нет" searchPromptText="Начните вводить" clearValueText="Удалить тег" clearAllText="Удалить все теги" autoload={false} multi={true} allowCreate={true} matchProp="label" asyncOptions={@loadOptions} value={@value()} newOptionCreator={@createNewOption} optionRenderer={@renderOption} onChange={@updateTags}/>

module.exports = connect()(TagsSelect)
