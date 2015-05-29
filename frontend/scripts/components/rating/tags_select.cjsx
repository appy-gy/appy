_ = require 'lodash'
React = require 'react/addons'
Select = require 'react-select'
RatingActionCreators = require '../../action_creators/ratings'
TagsApi = require '../../state_sources/tags'

{PropTypes} = React

TagsSelect = React.createClass
  displayName: 'TagsSelect'

  contextTypes:
    rating: PropTypes.object.isRequired

  toOptions: (tags) ->
    tags.map (tag) ->
      value: tag.name, label: tag.name

  loadOptions: (query, callback) ->
    TagsApi.for(@).autocomplete(query).then ({body}) =>
      callback null, options: @toOptions(body.tags)

  value: ->
    {rating} = @context

    @toOptions rating.tags

  updateTags: (name, options) ->
    {rating} = @context

    name = _.xor(_.map(rating.tags, 'name'), _.map(options, 'value'))[0]
    action = if options.length > rating.tags.length then 'add' else 'remove'
    RatingActionCreators["#{action}Tag"] rating.id, name

  render: ->
    <Select placeholder="Задать теги" noResultsText="Ничего такого нет" searchPromptText="Начните вводить" clearValueText="Удалить тег" clearAllText="Удалить все теги" autoload={false} multi={true} matchProp={'value'} asyncOptions={@loadOptions} value={@value()} onChange={@updateTags}/>

module.exports = TagsSelect
