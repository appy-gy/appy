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

  delimiter: '⟅'

  toOptions: (tags) ->
    tags.map (tag) ->
      value: tag.name, label: tag.name, ratingsCount: tag.ratingsCount

  loadOptions: (query, callback) ->
    # React-select passes current values instead of an empty string when
    # initialized or after adding/removing a value from the values list
    query = '' if _.includes query, @delimiter

    action = if _.isEmpty query then 'popular' else 'autocomplete'

    @app.tagsApi[action](query).then ({body, ok}) =>
      return callback 'Ошибка' unless ok
      {tags} = _.clone body.tags
      tags.unshift name: query unless _.isEmpty(query) or _(tags).map('name').includes(query)
      callback null, options: @toOptions(tags)

  value: ->
    {rating} = @context

    _.map(rating.tags, 'name').join(@delimiter)

  updateTags: (__, options) ->
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

    <Select placeholder="Укажите теги" noResultsText="Ничего такого нет" searchPromptText="Начните вводить" clearValueText="Удалить тег" clearAllText="Удалить все теги" autoload={true} multi={true} delimiter={@delimiter} matchProp={'value'} asyncOptions={@loadOptions} value={@value()} optionRenderer={@renderOption} onChange={@updateTags}/>

module.exports = TagsSelect
