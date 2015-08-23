_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Select = require 'react-select'
RatingUpdater = require '../mixins/rating_updater'
findInArray = require '../../helpers/find_in_array'

{PropTypes} = React

SectionSelect = React.createClass
  displayName: 'SectionSelect'

  mixins: [RatingUpdater]

  propTypes:
    sections: PropTypes.arrayOf(PropTypes.object).isRequired
    object: PropTypes.object.isRequired
    actions: PropTypes.string.isRequired

  changeSection: (sectionId) ->
    {sections, object, actions} = @props

    section = findInArray(sections, sectionId)

    @app[actions].change object.id, { section }
    @queueUpdate =>
      @app[actions].update object.id, { sectionId }

  options: ->
    {sections} = @props

    sections.map (section) ->
      value: section.id, label: section.name, color: section.color

  renderOption: ({label, color}) ->
    <div style={{color}}>
      {label}
    </div>

  render: ->
    {object} = @props

    <Select placeholder="Рубрика" value={object.section?.id} options={@options()} searchable={false} valueRenderer={@renderOption} optionRenderer={@renderOption} onChange={@changeSection}/>

module.exports = Marty.createContainer SectionSelect,
  listenTo: 'sectionsStore'

  fetch: ->
    sections: @app.sectionsStore.getAll()
