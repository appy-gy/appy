React = require 'react/addons'
Marty = require 'marty'
SectionsStore = require '../../stores/sections'

{PropTypes} = React

SectionsSelect = React.createClass
  displayName: 'SectionsSelect'

  propTypes:
    sections: PropTypes.arrayOf(PropTypes.object).isRequired
    object: PropTypes.object.isRequired

  updateSection: (event) ->
    {object, actionCreator} = @props

    actionCreator.save object, sectionId: event.target.value

  sections: ->
    {sections} = @props

    sections.map (section) ->
      <option key={section.id} value={section.id}>
        {section.name}
      </option>

  render: ->
    <select className="rating_section-name edit" onChange={@updateSection}>
      {@sections()}
    </select>

module.exports = Marty.createContainer SectionsSelect,
  listenTo: SectionsStore

  fetch: ->
    sections: SectionsStore.for(@).getAll()
