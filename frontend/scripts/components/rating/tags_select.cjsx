_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Select = require 'react-select'
Nothing = require '../shared/nothing'
Tag = require '../../models/tag'

{PropTypes} = React

TagsSelect = React.createClass
  displayName: 'TagsSelect'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    rating: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  toOptions: (tags) ->
    tags.map (tag) ->
      value: tag.name, label: tag.name, numberOfUses: tag.numberOfUses

  loadOptions: (query, callback) ->
    @app.tagsApi.autocomplete(query).then ({body, status}) =>
      return callback 'Ошибка' unless status == 200
      tags = body.tags.map (tag) -> new Tag tag
      tags.push new Tag name: query unless _(tags).map('name').includes(query)
      callback null, options: @toOptions(tags)

  value: ->
    {rating} = @context

    @toOptions rating.tags

  updateTags: (name, options) ->
    {rating} = @context

    name = _.xor(_.map(rating.tags, 'name'), _.map(options, 'value'))[0]
    action = if options.length > rating.tags.length then 'add' else 'remove'
    @app.ratingsActions["#{action}Tag"] rating.id, name

  renderOption: ({label, numberOfUses}) ->
    <div className="tag-option">
      <div className="tag-option_label">
        {label}
      </div>
      <div className="tag-option_number-of-uses">
        ({numberOfUses || 'новый'})
      </div>
    </div>

  render: ->
    {canEdit} = @context

    return <Nothing/> unless canEdit

    <Select placeholder="Задать теги" noResultsText="Ничего такого нет" searchPromptText="Начните вводить" clearValueText="Удалить тег" clearAllText="Удалить все теги" autoload={false} multi={true} matchProp={'value'} asyncOptions={@loadOptions} value={@value()} optionRenderer={@renderOption} onChange={@updateTags}/>

module.exports = TagsSelect
