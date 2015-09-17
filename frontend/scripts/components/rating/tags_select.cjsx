_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
http = require '../../helpers/http'
Select = require 'react-select'
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

  delimiter: '⟅'

  toOptions: (tags) ->
    tags.map (tag) ->
      value: tag.name, label: tag.name, ratingsCount: tag.ratingsCount

  loadOptions: (query, callback) ->
    # React-select passes current values instead of an empty string when
    # initialized or after adding/removing a value from the values list
    query = '' if _.includes query, @delimiter

    url = if _.isEmpty query then 'tags/popular' else 'tags'
    http.get(url, params: { query }).then ({data}) =>
      {tags} = data
      tags.unshift name: query unless _.isEmpty(query) or _(tags).map('name').includes(query)
      callback null, options: @toOptions(tags)

  value: ->
    {rating} = @context

    _.map(rating.tags, 'name').join(@delimiter)

  updateTags: (__, options) ->
    {dispatch} = @props
    {rating} = @context

    name = _.xor(_.map(rating.tags, 'name'), _.map(options, 'value'))[0]
    action = if options.length > rating.tags.length then addTagToRating else removeTagFromRating
    dispatch action(name)

  renderOption: ({label, ratingsCount}) ->
    <div className="tag-option">
      <div className="tag-option_label">
        {label}
      </div>
      <div className="tag-option_number-of-uses">
        ({ratingsCount || 'новый'})
      </div>
    </div>

  render: ->
    {canEdit} = @context

    return <Nothing/> unless canEdit

    <Select placeholder="Укажите теги" noResultsText="Ничего такого нет" searchPromptText="Начните вводить" clearValueText="Удалить тег" clearAllText="Удалить все теги" autoload={true} multi={true} delimiter={@delimiter} matchProp={'value'} asyncOptions={@loadOptions} value={@value()} optionRenderer={@renderOption} onChange={@updateTags}/>

module.exports = connect()(TagsSelect)
