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
      value: tag.name, label: tag.name, ratingsCount: tag.ratingsCount

  loadOptions: (query, callback) ->
    # React-select passes object instead of empty string when initialized
    # with some values or when new value added to list of values
    query = '' if _.isObject query

    action = if _.isEmpty query then 'popular' else 'autocomplete'

    @app.tagsApi[action](query).then ({body, status}) =>
      return callback 'Ошибка' unless status == 200
      tags = body.tags.map (tag) -> new Tag tag
      tags.unshift new Tag name: query unless _.isEmpty(query) or _(tags).map('name').includes(query)
      callback null, options: @toOptions(tags)

  value: ->
    {rating} = @context

    @toOptions rating.tags

  updateTags: (name, options) ->
    {rating} = @context

    name = _.xor(_.map(rating.tags, 'name'), _.map(options, 'value'))[0]
    action = if options.length > rating.tags.length then 'add' else 'remove'
    @app.ratingsActions["#{action}Tag"] rating.id, name

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

    <Select placeholder="Укажите теги" noResultsText="Ничего такого нет" searchPromptText="Начните вводить" clearValueText="Удалить тег" clearAllText="Удалить все теги" autoload={true} multi={true} matchProp={'value'} asyncOptions={@loadOptions} value={@value()} optionRenderer={@renderOption} onChange={@updateTags}/>

module.exports = TagsSelect
