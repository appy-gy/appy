_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Select = require 'react-select'
Nothing = require '../shared/nothing'

{PropTypes} = React

TagsSelect = React.createClass
  displayName: 'TagsSelect'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    rating: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  toOptions: (tags) ->
    tags.map (tag) ->
      value: tag.name, label: tag.name

  loadOptions: (query, callback) ->
    @app.tagsApi.autocomplete(query).then ({body}) =>
      callback null, options: @toOptions(body.tags)

  value: ->
    {rating} = @context

    @toOptions rating.tags

  updateTags: (name, options) ->
    {rating} = @context

    name = _.xor(_.map(rating.tags, 'name'), _.map(options, 'value'))[0]
    action = if options.length > rating.tags.length then 'add' else 'remove'
    @app.ratingsActions["#{action}Tag"] rating.id, name

  render: ->
    {canEdit} = @context

    return <Nothing/> unless canEdit

    <Select placeholder="Задать теги" noResultsText="Ничего такого нет" searchPromptText="Начните вводить" clearValueText="Удалить тег" clearAllText="Удалить все теги" autoload={false} multi={true} matchProp={'value'} asyncOptions={@loadOptions} value={@value()} onChange={@updateTags}/>

module.exports = TagsSelect
